require 'spec_helper'

module SmsBroker
  describe IncomingMessagesController do
    describe "POST #receive" do
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

    end
  end
end