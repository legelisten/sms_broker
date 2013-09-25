module SmsBroker

  class IncomingMessageHook

    #
    # This method should be overriden
    #
    def self.execute(message)
    end

  end
end