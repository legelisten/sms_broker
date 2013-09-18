LegelistenSms::Engine.routes.draw do

  post :receive, to: 'incoming_messages#receive'

end
