module SmsBroker
  class Engine < ::Rails::Engine
    isolate_namespace SmsBroker

    config.generators do |g|
      g.test_framework      :rspec,        :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.factory_girl :dir => 'spec/factories'
      g.assets false
      g.helper false
    end
  end

  def self.config(&block)
    if block
      yield Engine.config
    else
      Engine.config
    end
  end

  config.incoming_text_encoding = "ISO-8859-1"
  config.pswincom_user = ENV['SMS_SEND_USER'] || 'dummy'
  config.pswincom_password = ENV['SMS_SEND_PASSWORD'] || 'dummy'
  config.pswincom_reception_url = ENV['SMS_SEND_URL']
  config.reception_ip_whitelist = ['127.0.0.1']

  if ENV['SMS_IP_WHITELIST']
    config.reception_ip_whitelist = config.reception_ip_whitelist | ENV['SMS_IP_WHITELIST'].split(",")
  end

end