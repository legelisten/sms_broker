class CreateLegelistenSmsIncomingSms < ActiveRecord::Migration
  def change
    create_table :legelisten_sms_incoming_messages do |t|
      t.string :receiver_number
      t.string :sender_number
      t.string :text

      t.timestamps
    end
  end
end
