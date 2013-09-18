module LegelistenSms
  class OutgoingMessage < ActiveRecord::Base
    after_create :handle_message

  private

    def handle_message
      OutgoingMessageHandler.new(self).execute
    end
    handle_asynchronously :handle_message

  end
end
