module SmsBroker
  class OutgoingMessage < ActiveRecord::Base
    belongs_to :incoming_message

    validates :recipient, :sender, :text, presence: true

    after_initialize :init
    after_create :fire_hooks

    NEW       = 'NEW'
    RETRYING  = 'RETRYING'
    SENT      = 'SENT'
    FAILED    = 'FAILED'

    scope :sent,   -> { where(status: SENT) }
    scope :unsent, -> { where('status != ?', SENT) }

    @@after_create_hooks = Array.new

    # :reek:Manual-Dispatch
    def init
      if SmsBroker.config.respond_to? :default_sender
        self.sender ||= SmsBroker.config.default_sender
      end

      self.status ||= SmsBroker::OutgoingMessage::NEW
      self.delivery_attempts ||= 0
    end

    ##
    # Prepend 8 digit phone numbers with Norwegian country code.
    #
    # PSWinCom / LinkMobility expects phone numbers to be at least 9 digits,
    # and thus Norwegian numbers should be prefixed with 47.
    #
    def recipient=(phone_number)
      recipient = if phone_number =~ /\A(4|9)\d{7}\Z/
                    '47' + phone_number
                  else
                    phone_number
                  end

      write_attribute(:recipient, recipient)
    end

    def self.register_after_create_hook(hook)
      unless @@after_create_hooks.include?(hook)
        @@after_create_hooks << hook
      end
    end

    def self.build_from_incoming(incoming_message)
      message = OutgoingMessage.new
      message.incoming_message = incoming_message
      message.recipient = incoming_message.sender

      message
    end

  private

    def fire_hooks
      @@after_create_hooks.each do |hook|
        hook.execute(self)
      end
    end
  end
end
