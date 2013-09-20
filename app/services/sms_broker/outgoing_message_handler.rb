module SmsBroker
  class OutgoingMessageHandler

    def initialize(message)
      @message = message
    end

    def execute
      Delayed::Job.enqueue SendSmsJob.new(@message), :queue => 'sms'
    end

  end
end