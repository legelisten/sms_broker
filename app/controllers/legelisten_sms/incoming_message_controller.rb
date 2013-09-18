require_dependency "legelisten_sms/application_controller"

module LegelistenSms
  class IncomingMessagesController < ApplicationController
    def receive
      message = IncomingMessage.new
      message.sender_number = params[:SND]
      message.receiver_number = params[:RCV]
      message.text = params[:TXT]

      if message.save
        return head :ok
      else
        return head :bad_request
      end
    end
  end
end
