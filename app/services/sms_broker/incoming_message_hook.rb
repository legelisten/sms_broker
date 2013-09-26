module SmsBroker

  class IncomingMessageHook

    #
    # This method should be overriden
    #
    def self.execute(message)
      raise
    end

  end
end