= sms_broker

These environment variables need to be set to configure the communication with PSWinCom.

SMS_GW_USER
SMS_GW_PASSWORD
SMS_GW_SENDER - Name displayed as the sender of the SMS


== Installation

Add sms_broker to the applications `Gemfile`:

    gem 'sms_broker', :git => 'git://github.com/legelisten/sms_broker.git'

To set up sms_broker's routes, and make it available under `http://yourapp.com/sms_broker/receive`, add the following to `config/routes.rb`:

    mount SmsBroker::Engine, at: "/sms_broker"

The gem also supplies a few necessary database tables. To install and run the migrations, issue

    rake blorgh:install:migrations
    rake db:migrate