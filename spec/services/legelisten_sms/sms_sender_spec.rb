require 'spec_helper'

module LegelistenSms
  describe SmsSender do
    describe "#send" do
      it "returns true when sending SMS is successful" do
        message = OutgoingMessage.new
        message.recipient = "4791788471"
        message.text = "Test"

        VCR.use_cassette('pswincom/valid_sms', :match_requests_on => [:method]) do
          result = SmsSender.new.send(message)

          result.should == true
        end
      end

      it "returns false when server returns a non-200 response" do
        message = OutgoingMessage.new
        message.recipient = "4791788471"
        message.text = "Test"

        VCR.use_cassette('pswincom/non-200-response', :match_requests_on => [:method]) do
          sender = SmsSender.new

          sender.send(message).should == false
        end
      end

      it "returns false when server returns respons with unfamiliar body" do
        message = OutgoingMessage.new
        message.recipient = "4791788471"
        message.text = "Test"

        VCR.use_cassette('pswincom/non-xml-response', :match_requests_on => [:method]) do
          result = SmsSender.new.send(message)
          result.should == false
        end
      end


      it "returns false when PSWinCom API raises exception" do
        message = OutgoingMessage.new
        message.recipient = "4791788471"
        message.sender = "Legelisten"
        #message.tariff = 1
        #message.service_code = "01234"
        message.text = "Test"

        PSWinCom::API.any_instance.should_receive(:send_sms) { raise }

        VCR.use_cassette('pswincom/invalid_host') do
          SmsSender.new.send(message).should == false
        end
      end

    end
  end
end