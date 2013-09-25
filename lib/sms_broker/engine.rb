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
end