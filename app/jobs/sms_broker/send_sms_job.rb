module SmsBroker
  class SendSmsJob < Struct.new(:message, :test_mode)

    def perform
      begin
        if test_mode
          return true
        else
          return SmsSender.new.send(message)
        end
      rescue Exception => e
        raise("Unable to deliver SMS to gateway: #{e.message}")
      end
    end

    def success(job)
      message.status = OutgoingMessage::SENT
      message.save!
    end

    def failure(job)
      message.status = OutgoingMessage::FAILED
      message.save!
    end

    def error(job, exception)
      message.reload if message.id
      message.increment(:delivery_attempts)
      message.save!
    end

  end
end