class CreateLegelistenSmsOutgoingSms < ActiveRecord::Migration
  def change
    create_table :legelisten_sms_outgoing_messages do |t|

      t.timestamps
    end
  end
end
