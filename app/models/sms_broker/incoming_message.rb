module SmsBroker
  class IncomingMessage < ActiveRecord::Base
    validates :recipient, :sender, presence: true

    after_create :handle_message
  private

    def handle_message
      IncomingMessageHook.execute(self)
    end
  end
end