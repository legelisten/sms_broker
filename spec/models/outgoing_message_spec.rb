require 'spec_helper'

module SmsBroker
  describe OutgoingMessage do
    describe "after_create" do
      it 'should run the proper callbacks' do
        subject = OutgoingMessage.new
        subject.should_receive(:handle_message)

        subject.run_callbacks(:create)
      end
    end

    describe "after_initialize" do
      it "sets status to NEW" do
        subject.status.should == OutgoingMessage::NEW
      end

      it "sets delivery_attempts to 0" do
        subject.delivery_attempts.should == 0
      end
    end

    describe ".build_from_incoming" do
      it "uses incoming message to set up new object" do
        incoming_message = build :incoming_message, id: 1

        outgoing_message = OutgoingMessage.build_from_incoming(incoming_message)

        outgoing_message.incoming_message.should == incoming_message
        outgoing_message.recipient.should == incoming_message.sender
      end
    end

    describe "after_initalize" do
      it "does not set sender default value is not set" do
        OutgoingMessage.new.sender.should == nil
      end

      it "sets sender to configured default when default value is set" do
        SmsBroker.config do |c|
          c.stub(:default_sender) { "TestSender" }
        end

        OutgoingMessage.new.sender.should == "TestSender"
      end
    end
  end
end