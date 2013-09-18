module LegelistenSms
  class IncomingMessage < ActiveRecord::Base
    validates :receiver_number, :sender_number, presence: true

    after_create :handle_message

  private

    def handle_message
      IncomingMessageHandler.new(self).execute
    end
  end
end
