require 'spec_helper'

module SmsBroker
  describe SendSmsJob do

    describe "#perform" do
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

    describe "#error" do
      it "should increase message's delivery attempts counter" do
        message = OutgoingMessage.new
        message.should_receive(:save!)
        job = SendSmsJob.new(message)

        job.error(job, Exception.new)

        message.delivery_attempts.should == 1
      end
    end

    describe "#failure" do
      it "should set message status to indicate failure" do
        message = OutgoingMessage.new
        message.should_receive(:save!)
        job = SendSmsJob.new(message)

        job.failure(job)

        message.status.should == OutgoingMessage::FAILED
      end
    end

    describe "#success" do
      it "should set message status to indicate success" do
        message = OutgoingMessage.new
        message.should_receive(:save!)
        job = SendSmsJob.new(message)

        job.success(job)

        message.status.should == OutgoingMessage::SENT
      end
    end
  end
end