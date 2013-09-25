module SmsBroker
  class OutgoingMessage < ActiveRecord::Base
    belongs_to :incoming_message

    validates :recipient, :sender, :text, presence: true

    after_initialize :init
    after_create     :handle_message

    NEW     = 'NEW'
    FAILED  = 'FAILED'
    SENT    = 'SENT'

    def init
      if SmsBroker.config.respond_to? :default_sender
        self.sender = SmsBroker.config.default_sender
      end

      self.status = OutgoingMessage::NEW
      self.delivery_attempts = 0
    end

    def self.build_from_incoming(incoming_message)
      message = OutgoingMessage.new
      message.incoming_message = incoming_message
      message.recipient = incoming_message.sender

      message
    end

  private

    def handle_message
      OutgoingMessageHook.execute(self)
    end
  end
end
