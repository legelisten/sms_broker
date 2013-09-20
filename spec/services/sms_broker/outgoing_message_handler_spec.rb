require 'spec_helper'

module SmsBroker
  describe OutgoingMessageHandler do
    describe "#execute" do
      it "adds an SendSmsJob to the work que" do
        handler = OutgoingMessageHandler.new(nil)
        Delayed::Job.should_receive(:enqueue).with(an_instance_of(SendSmsJob), anything())

        handler.execute
      end

    end
  end
end