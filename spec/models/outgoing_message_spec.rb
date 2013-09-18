require 'spec_helper'

module LegelistenSms
  describe OutgoingMessage do
    describe "after_create" do
      it 'should run the proper callbacks' do
        subject = OutgoingMessage.new
        subject.should_receive(:handle_message)

        subject.run_callbacks(:create)
      end
    end
  end
end