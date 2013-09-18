class OutgoingMessageHandler

    def initialize(message)
      @message = message
      @sms_sender = SmsSender.new(@message)
    end

    def execute
      if @sms_sender.send
        return true
      else
        raise
      end
    end

end