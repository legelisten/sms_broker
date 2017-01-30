require 'spec_helper'

module SmsBroker
  describe OutgoingMessage do

    describe "after_create" do
      after(:each) { SmsBroker::OutgoingMessage.class_variable_set :@@after_create_hooks, Array.new }

      it 'should trigger the registered hooks' do
        hook = double(:hook)
        expect(hook).to receive(:execute)

        SmsBroker::OutgoingMessage.register_after_create_hook(hook)

        subject.run_callbacks(:create)
      end
    end

    describe "after_initialize" do
      it "sets status to NEW" do
        expect(subject.status).to eq OutgoingMessage::NEW
      end

      it "sets delivery_attempts to 0" do
        expect(subject.delivery_attempts).to eq 0
      end

      it "does not set sender default value is not set" do
        expect(OutgoingMessage.new.sender).to eq nil
      end

      it "sets sender to configured default when default value is set" do
        SmsBroker.config do |c|
          allow(c).to receive(:default_sender) { "TestSender" }
        end

        expect(OutgoingMessage.new.sender).to eq "TestSender"
      end
    end

    describe "#recipient=" do
      context "8 digit phone number" do
        let(:phone) { "98765432" }

        it 'adds norwegian country code as prefix' do
          subject.recipient = phone

          expect(subject.recipient).to eq "47#{phone}"
        end
      end

      context "more than 8 digit phone number" do
        let(:phone) { "987654321" }

        it 'leaves phone number unmodified' do
          subject.recipient = phone

          expect(subject.recipient).to eq phone
        end
      end

      context "already prefixed Norwgian phone number" do
        let(:phone) { "4798765432" }

        it 'leaves phone number unmodified' do
          subject.recipient = phone

          expect(subject.recipient).to eq phone
        end
      end
    end

    describe ".build_from_incoming" do
      it "uses incoming message to set up new object" do
        incoming_message = build :incoming_message, id: 1

        outgoing_message = OutgoingMessage.build_from_incoming(incoming_message)

        expect(outgoing_message.incoming_message).to eq incoming_message
        expect(outgoing_message.recipient).to eq incoming_message.sender
      end
    end
  end
end
