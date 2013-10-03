require 'pswincom'

module SmsBroker
  class SmsSender

    def initialize
      ::PSWinCom::API.api_host = SmsBroker.config.pswincom_reception_url
      @api = ::PSWinCom::API.new SmsBroker.config.pswincom_user, SmsBroker.config.pswincom_password

    end

    def send(message)
      options = Hash.new
      options[:sender] = message.sender unless message.sender.nil?
      options[:tariff] = message.tariff unless message.tariff.nil?
      options[:servicecode] = message.service_code unless message.service_code.nil?

      result = @api.send_sms message.recipient,
                             message.text,
                             {sender: message.sender,
                             tariff: message.tariff,
                             servicecode: message.service_code}

      http_response_ok?(result) || raise("HTTP response code not 200: #{result.to_s}")
      gateway_response_ok?(result) || raise("Unexpected response from gateway: #{result.body}")

      return true
    end

  private

    def http_response_ok?(result)
      result.is_a? Net::HTTPOK
    end

    def gateway_response_ok?(result)
      doc = REXML::Document.new(result.body)

      is_valid_xml = !doc.root.nil?
      login_ok = false
      message_ok = false

      if is_valid_xml
        root = doc.root
        login_ok = root.elements["//LOGON"] && root.elements["//LOGON"].text == "OK"
        message_ok = root.elements["//MSGLST/MSG/STATUS"] && root.elements["//MSGLST/MSG/STATUS"].text == "OK"
      end

      return (is_valid_xml && login_ok && message_ok)
    end

  end
end