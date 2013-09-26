module SmsBroker

  class IncomingMessageHook

    #
    # This method should be overriden
    #
    def self.execute(message)
      raises
    end

  end
end