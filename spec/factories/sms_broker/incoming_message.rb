FactoryGirl.define do
  factory :incoming_message, class: SmsBroker::IncomingMessage do
    recipient     "2077"
    sender        "12345678"
    text          "LL SomeRandomText"
  end
end