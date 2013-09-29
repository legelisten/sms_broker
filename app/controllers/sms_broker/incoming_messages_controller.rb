require_dependency "sms_broker/application_controller"

module SmsBroker
  class IncomingMessagesController < ApplicationController
    before_filter :restrict_access

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

  private

    def restrict_access
      whitelist = SmsBroker.config.reception_ip_whitelist

      unless whitelist.include? request.remote_ip
        return head :unauthorized
      end
    end

  end
end
