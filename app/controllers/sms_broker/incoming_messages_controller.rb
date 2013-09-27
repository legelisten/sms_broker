require_dependency "sms_broker/application_controller"

module SmsBroker
  class IncomingMessagesController < ApplicationController
    http_basic_authenticate_with name: ENV['SMS_RECEIVE_USER'], password: ENV['SMS_RECEIVE_PASSWORD']

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
