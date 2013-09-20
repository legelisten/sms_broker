Rails.application.routes.draw do

  mount SmsBroker::Engine => "/sms_broker"
end
