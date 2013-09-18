class SmsSender

  def initialize(message)
    @message = message

    username = 'dummy' || ENV['SMS_GW_USER']
    password = 'dummy' || ENV['SMS_GW_PASSWORD']

    @api = PSWinCom::API.new username, password
  end

  def send
    result = api.send_sms message.receiver_number,
                             message.text,
                             sender: ENV['SMS_GATEWAY_SENDER'],
                             tariff: message.tariff,
                             servicecode: message.service_code

    return result.between? 200, 206
  end

end