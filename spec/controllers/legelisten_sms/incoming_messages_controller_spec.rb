require 'spec_helper'

module LegelistenSms
  describe IncomingMessagesController do
    describe "POST #receive" do
      it "returns 200 when IncomingMessage saved" do
        IncomingMessage.any_instance.stub(:save) { true }

        get :receive, {:use_route => :post}

        assert_response 200
      end

      it "returns 400 when saving IncomingMessage fails" do
        IncomingMessage.any_instance.stub(:save) { false }

        get :receive, {:use_route => :post}

        assert_response 400
      end

    end
  end
end