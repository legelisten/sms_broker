module LegelistenSms
  class SendSmsJob < Struct.new(:message)

    def initialize(message)
      @message = message
    end

    def perform
      SmsSender.new.send(@message) || raise('Could not send SMS')
    end

    def success(job)
      @message.status = OutgoingMessage::SENT
      @message.save!
    end

    def failure(job)
      @message.status = OutgoingMessage::FAILED
      @message.save!
    end

    def error(job, exception)
      @message.delivery_attempts += 1
      @message.save!
    end

  end
end