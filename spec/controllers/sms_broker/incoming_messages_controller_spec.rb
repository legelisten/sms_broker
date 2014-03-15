# encoding: utf-8

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
        get :receive, {:use_route => :sms_broker, "ID"=>"1", "SND"=>"12345678", "RCV"=>"26112", "TXT"=>"LEGELISTEN blablabla"}, nil

        IncomingMessage.count.should == 1
      end

      it 'saves all input in IncomingMessage' do
        sender = "12345678"
        recipient = "87654321"
        text = "Test"

        get :receive, {:SND => sender,
                      :RCV => recipient,
                      :TXT => text,
                      :use_route => :sms_broker}

        message = IncomingMessage.first
        expect(message.sender).to eq sender
        expect(message.recipient).to eq recipient
        expect(message.text).to eq text
      end

      it 'ensures correct encoding on incoming text' do
        get :receive, {:TXT => "Test \xE6\xF8\xE5", # ISO-8859-1 characters (æøå)
                       :SND => "1",
                       :RCV => "2",
                       :use_route => :sms_broker}

        message = IncomingMessage.first

        expect(message.text.valid_encoding?).to be_true
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