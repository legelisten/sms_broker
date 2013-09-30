module SmsBroker
  class IncomingMessage < ActiveRecord::Base
    validates :recipient, :sender, presence: true

    after_create :fire_hooks

    @@after_create_hooks = Array.new

    def self.register_after_create_hook(hook)
      unless @@after_create_hooks.include?(hook)
        @@after_create_hooks << hook
      end
    end

  private

    def fire_hooks
      @@after_create_hooks.each do |hook|
        hook.execute(self)
      end
    end
  end
end