require 'spec_helper'

module SmsBroker
  describe SmsSender do
    describe "#send" do
      it "returns true when sending SMS is successful" do
        message = OutgoingMessage.new
        message.recipient = "4791788471"
        message.text = "Test"

        VCR.use_cassette('pswincom/valid_sms', :match_requests_on => [:method]) do
          result = SmsSender.new.send(message)

          expect(result).to eq true
        end
      end

      it "raises exception when server returns a non-200 response" do
        message = OutgoingMessage.new
        message.recipient = "4791788471"
        message.text = "Test"

        VCR.use_cassette('pswincom/non-200-response', :match_requests_on => [:method]) do
          expect{ SmsSender.new.send(message) }.to raise_error RuntimeError
        end
      end

      it "raises exception when server returns response with unfamiliar body" do
        message = OutgoingMessage.new
        message.recipient = "4791788471"
        message.text = "Test"

        VCR.use_cassette('pswincom/non-xml-response', :match_requests_on => [:method]) do
          expect { SmsSender.new.send(message) }.to raise_error RuntimeError
        end
      end

      it "raises exception when server returns response with message failed status" do
        message = OutgoingMessage.new
        message.recipient = "91788471"
        message.text = "Test"

        VCR.use_cassette('pswincom/message-validation-error', :match_requests_on => [:method]) do
          expect { SmsSender.new.send(message) }.to raise_error RuntimeError
        end
      end

      it "raises exception when PSWinCom API raises exception" do
        message = OutgoingMessage.new
        message.recipient = "4791788471"
        message.sender = "Legelisten"
        message.text = "Test"

        expect_any_instance_of(PSWinCom::API).to receive(:send_sms) { raise }

        VCR.use_cassette('pswincom/invalid_host') do
          expect { SmsSender.new.send(message) }.to raise_error RuntimeError
        end
      end

    end
  end
end