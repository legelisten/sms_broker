# encoding: utf-8

require 'spec_helper'

module SmsBroker
  describe IncomingMessage do

    describe "after_create" do
      after(:each) { SmsBroker::IncomingMessage.class_variable_set :@@after_create_hooks, Array.new }

      it 'should trigger the registered hooks' do
        hook = double(:hook)
        hook.should_receive(:execute)

        SmsBroker::IncomingMessage.register_after_create_hook(hook)

        subject.run_callbacks(:create)
      end
    end

    describe "#text=" do
      it 'utf-8 encodes the text' do
        subject.text = "æøå".encode('ISO-8859-1')

        expect(subject.text.encoding.name).to eq "UTF-8"
      end
    end

  end
end