module SmsBroker
  class IncomingMessagesController < ApplicationController
    before_action :restrict_access

    def receive
      message = IncomingMessage.new
      message.sender = params[:SND]
      message.recipient = params[:RCV]
      message.text = force_encoding(params[:TXT])

      if message.save
        return head :ok
      else
        return head :bad_request
      end
    end

  private

    def force_encoding(string)
      if string && SmsBroker.config.incoming_encoding
        return string.force_encoding(SmsBroker.config.incoming_encoding)
                     .encode(SmsBroker.config.app_encoding)
      else
        return string
      end
    end

    def restrict_access
      whitelist = SmsBroker.config.reception_ip_whitelist

      unless whitelist.include? request.remote_ip
        return head :unauthorized
      end
    end

  end
end
