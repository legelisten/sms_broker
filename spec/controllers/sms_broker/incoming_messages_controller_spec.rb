# encoding: utf-8

require 'spec_helper'

module SmsBroker
  describe IncomingMessagesController do
    routes { SmsBroker::Engine.routes }

    describe "POST #receive" do

      before(:each) do
        request.remote_addr = '127.0.0.1'
      end

      it "returns 200 when IncomingMessage saved" do
        allow_any_instance_of(IncomingMessage).to receive(:save) { true }
        post :receive

        assert_response 200
      end

      it "returns 400 when saving IncomingMessage fails" do
        allow_any_instance_of(IncomingMessage).to receive(:save) { false }

        get :receive

        assert_response 400
      end

      it "stores the incoming message" do
        sender = "12345678"
        recipient = "87654321"
        text = "Test"

        get :receive, params: { SND: sender,
                                RCV: recipient,
                                TXT: text }

        expect(IncomingMessage.count).to eq 1
      end

      it 'saves all input in IncomingMessage' do
        sender = "12345678"
        recipient = "87654321"
        text = "Test"

        get :receive, params: { SND: sender,
                                RCV: recipient,
                                TXT: text}

        message = IncomingMessage.first
        expect(message.sender).to eq sender
        expect(message.recipient).to eq recipient
        expect(message.text).to eq text
      end

      context "whitelisting of IP addresses" do
        it "returns 401 when ip address not whitelisted" do
          SmsBroker.config.reception_ip_whitelist = ['1.2.3.4']
          request.remote_addr = '4.3.2.1'

          get :receive

          assert_response 401
        end

        it "returns something other than 200 when ip address is whitelisted" do
          SmsBroker.config.reception_ip_whitelist = ['1.2.3.4']
          request.remote_addr = '1.2.3.4'

          get :receive

          expect(response.status).to_not eq 401
        end

        it "handles multiple whitelisted addresses" do
          SmsBroker.config.reception_ip_whitelist = ['4.3.2.1', '1.2.3.4']
          request.remote_addr = '1.2.3.4'

          get :receive

          expect(response.status).to_not eq 401
        end
      end
    end
  end
end
