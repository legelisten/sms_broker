require 'pswincom'

module SmsBroker
  class SmsSender

    def initialize
      username = ENV['SMS_GW_USER'] || 'dummy'
      password = ENV['SMS_GW_PASSWORD'] || 'dummy'
      host     = ENV['SMS_GW_HOST']

      ::PSWinCom::API.api_host = host if host
      @api = ::PSWinCom::API.new username, password

    end

    def send(message)
      options = Hash.new
      options[:sender] = message.sender unless message.sender.nil?
      options[:tariff] = message.tariff unless message.tariff.nil?
      options[:servicecode] = message.service_code unless message.service_code.nil?

      begin
        result = @api.send_sms message.recipient,
                               message.text,
                               {sender: message.sender,
                               tariff: message.tariff,
                               servicecode: message.service_code}

        return (http_response_ok?(result) and gateway_response_ok?(result))
      rescue Exception => e
        return false
      end
    end

  private

    def http_response_ok?(result)
      result.is_a? Net::HTTPOK
    end

    def gateway_response_ok?(result)
      doc = REXML::Document.new(result.body)

      login_ok = doc.root.elements["//LOGON"].text == "OK"
      message_ok =  doc.root.elements["//MSGLST/MSG/STATUS"].text == "OK"

      return (login_ok and message_ok)
    end

  end
end