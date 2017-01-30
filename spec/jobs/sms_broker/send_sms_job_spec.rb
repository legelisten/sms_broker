require 'spec_helper'

module SmsBroker
  describe SendSmsJob do

    describe "#perform" do
      it "raises exception if sending of SMS fails" do
        job = SendSmsJob.new(nil)
        # Raising any error here, but because of rspec warning (read below) need to specify type
        # WARNING: Using the `raise_error` matcher without providing a specific error
        # or message risks false positives, since `raise_error` will match when Ruby raises a
        # `NoMethodError`, `NameError` or `ArgumentError`, potentially allowing
        # the expectation to pass without even executing the method you are intending to call.
        allow_any_instance_of(SmsSender).to receive(:send) { raise NoMethodError }

        expect { job.perform }.to raise_error NoMethodError
      end

      it "returns true if sending of SMS succeeds" do
        message = double(:message)
        allow(message).to receive(:increment)
        handler = SendSmsJob.new(message)
        allow_any_instance_of(SmsSender).to receive(:send) { true }

        expect(handler.perform).to eq true
      end

      it "should increase message's delivery attempts counter" do
        message = OutgoingMessage.new
        handler = SendSmsJob.new(message)
        allow_any_instance_of(SmsSender).to receive(:send) { true }

        handler.perform

        expect(message.delivery_attempts).to eq 1
      end
    end

    describe "#error" do
    end

    describe "#failure" do
      it "should set message status to indicate failure" do
        message = OutgoingMessage.new
        job = SendSmsJob.new(message)

        job.failure(job)

        expect(message.status).to eq OutgoingMessage::FAILED
      end
    end

    describe "#success" do
      it "should set message status to indicate success" do
        message = OutgoingMessage.new
        job = SendSmsJob.new(message)

        job.success(message)

        expect(message.status).to eq OutgoingMessage::SENT
      end
    end
  end
end