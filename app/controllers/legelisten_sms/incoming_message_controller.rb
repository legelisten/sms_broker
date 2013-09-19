require_dependency "legelisten_sms/application_controller"

module LegelistenSms
  class IncomingMessagesController < ApplicationController
    def receive
      message = IncomingMessage.new
      message.sender = params[:SND]
      message.recipient = params[:RCV]
      message.text = params[:TXT]

      if message.save
        return head :ok
      else
        return head :bad_request
      end
    end
  end
end
