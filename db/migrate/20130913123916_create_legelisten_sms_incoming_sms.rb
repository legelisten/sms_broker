class CreateLegelistenSmsIncomingSms < ActiveRecord::Migration
  def change
    create_table :legelisten_sms_incoming_messages do |t|
      t.string :recipient
      t.string :sender
      t.string :text

      t.timestamps
    end
  end
end
