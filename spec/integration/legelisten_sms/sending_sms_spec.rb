require "spec_helper"

module LegelistenSms
  describe "sending SMS" do
    it "stores and sends the outgoing SMS message" do
      VCR.use_cassette('pswincom/valid_sms', :match_requests_on => []) do
        message = create :outgoing_message

        message.status.should == OutgoingMessage::SENT
        OutgoingMessage.count == 1
      end
    end
  end
end