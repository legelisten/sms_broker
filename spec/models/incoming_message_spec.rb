require 'spec_helper'

module LegelistenSms
  describe IncomingMessage do
    describe "after_create" do
      it 'should run the proper callbacks' do
        subject = IncomingMessage.new
        subject.should_receive(:handle_message)

        subject.run_callbacks(:create)
      end
    end
  end
end