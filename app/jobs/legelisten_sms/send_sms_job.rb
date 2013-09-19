module LegelistenSms
  class SendSmsJob < Struct.new(:message)

    def initialize(message)
      @message = message
      @sms_sender = SmsSender.new(@message)
    end

    def perform
      @sms_sender.send || raise
    end

  end
end