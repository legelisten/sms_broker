require 'spec_helper'

module LegelistenSms
  describe SendSmsJob do
    describe "#execute" do
      it "raises exception if sending of SMS fails" do
        job = SendSmsJob.new(nil)
        SmsSender.any_instance.stub(:send) { false }

        expect { job.perform }.to raise_error
      end

      it "returns true if sending of SMS succeeds" do
        handler = SendSmsJob.new(nil)
        SmsSender.any_instance.stub(:send) { true }

        handler.perform.should == true
      end
    end
  end
end