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

  end
end