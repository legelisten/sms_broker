class CreateSmsBrokerIncomingMessages < ActiveRecord::Migration
  def change
    create_table :sms_broker_incoming_messages do |t|
      t.string :recipient
      t.string :sender
      t.string :text

      t.timestamps
    end
  end
end
