FactoryGirl.define do
  factory :outgoing_message, class: LegelistenSms::OutgoingMessage do
    recipient       "2077"
    sender          "12345678"
    text            "LL SomeRandomText"

    trait :premium do
      tariff        Random.rand(300)
      service_code  "07001"
    end

    # trait :sent do
    #   status        LegelistenSms::OutgoingMessage::SENT
    # end

    # trait :failed do
    #   status        LegelistenSms::OutgoingMessage::FAILED
    # end
  end
end