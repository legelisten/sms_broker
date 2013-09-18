require 'spec_helper'

module LegelistenSms
  describe OutgoingMessageHandler do
    describe "#execute" do
      it "raises exception if sending of SMS fails" do
        handler = OutgoingMessageHandler.new(nil)
        SmsSender.any_instance.stub(:send) { false }

        expect { handler.execute }.to raise_error
      end

      it "returns true if sending of SMS succeeds" do
        handler = OutgoingMessageHandler.new(nil)
        SmsSender.any_instance.stub(:send) { true }

        handler.execute.should == true
      end
    end
  end
end