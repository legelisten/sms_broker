LegelistenSms::Engine.routes.draw do

  post :receive, to: 'incoming_messages#receive', as: :sms_reception

end
