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

    describe "after_initialize" do
      it "sets status to NEW" do
        subject.status.should == OutgoingMessage::NEW
      end

      it "sets delivery_attempts to 0" do
        subject.delivery_attempts.should == 0
      end
    end
  end
end