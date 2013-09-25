module SmsBroker
  class OutgoingMessageHook

    def self.execute(message)
      Delayed::Job.enqueue SendSmsJob.new(message), :queue => 'sms'
    end

  end
end