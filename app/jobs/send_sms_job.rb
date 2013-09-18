class SendSMSJob < Struct.new(:message)
  def perform
    OutgoingMessageHandler.new(message).execute
  end
end