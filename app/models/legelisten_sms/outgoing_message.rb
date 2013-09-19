module LegelistenSms
  class OutgoingMessage < ActiveRecord::Base
    has_one :incoming_message

    validates :receiver_number, :sender_number, :text, presence: true

    after_initialize :init
    after_create     :handle_message

    NEW     = 'NEW'
    FAILED  = 'FAILED'
    SENT    = 'SENT'

    def init
      self.status = OutgoingMessage::NEW
      self.delivery_attempts = 0
    end

  private

    def handle_message
      OutgoingMessageHandler.new(self).execute
    end
  end
end
