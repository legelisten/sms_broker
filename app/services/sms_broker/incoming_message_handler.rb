#
# The execute method of this class should be overridden by implementors of the engine.
#
class IncomingMessageHandler

    def initialize(incoming_message)
      @message = incoming_message
    end

    def execute
      return true
    end

end