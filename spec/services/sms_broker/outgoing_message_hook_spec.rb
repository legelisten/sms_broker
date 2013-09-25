require 'spec_helper'

module SmsBroker
  describe OutgoingMessageHook do
    describe "#execute" do
      it "adds an SendSmsJob to the work que" do
        Delayed::Job.should_receive(:enqueue).with(an_instance_of(SendSmsJob), anything())
        message = build :outgoing_message

        OutgoingMessageHook.execute(message)
      end

    end
  end
end