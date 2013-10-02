require 'spec_helper'

module SmsBroker
  describe IncomingMessagesController do
    describe "POST #receive" do

      before(:each) do
        request.remote_addr = '127.0.0.1'
      end

      it "returns 200 when IncomingMessage saved" do
        IncomingMessage.any_instance.stub(:save) { true }
        get :receive, {:use_route => :sms_broker}

        assert_response 200
      end

      it "returns 400 when saving IncomingMessage fails" do
        IncomingMessage.any_instance.stub(:save) { false }

        get :receive, {:use_route => :sms_broker}

        assert_response 400
      end

      it "stores the incoming message" do
        post :receive, {:use_route => :sms_broker, "ID"=>"1", "SND"=>"12345678", "RCV"=>"26112", "TXT"=>"LEGELISTEN blablabla"}, nil

        IncomingMessage.count.should == 1
      end

      context "whitelisting of IP addresses" do
        it "returns 401 when ip address not whitelisted" do
          SmsBroker.config.reception_ip_whitelist = ['1.2.3.4']
          request.remote_addr = '4.3.2.1'

          get :receive, {:use_route => :sms_broker}

          assert_response 401
        end

        it "returns something other than 200 when ip address is whitelisted" do
          SmsBroker.config.reception_ip_whitelist = ['1.2.3.4']
          request.remote_addr = '1.2.3.4'

          get :receive, {:use_route => :sms_broker}

          response.status.should_not == 401
        end

        it "handles multiple whitelisted addresses" do
          SmsBroker.config.reception_ip_whitelist = ['4.3.2.1', '1.2.3.4']
          request.remote_addr = '1.2.3.4'

          get :receive, {:use_route => :sms_broker}

          response.status.should_not == 401
        end
      end
    end
  end
end