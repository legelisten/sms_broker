class CreateLegelistenSmsOutgoingSms < ActiveRecord::Migration
  def change
    create_table :legelisten_sms_outgoing_messages do |t|
      t.integer :incoming_message_id

      t.string  :recipient
      t.string  :sender
      t.string  :text
      t.integer :tariff
      t.string  :service_code

      t.integer :delivery_attempts
      t.string  :status

      t.timestamps
    end
  end
end
