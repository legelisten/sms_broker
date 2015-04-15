class ChangeSmsTextType < ActiveRecord::Migration
  def up
    change_column :sms_broker_outgoing_messages, :text, :text, limit: 1600
  end

  def down
    change_column :sms_broker_outgoing_messages, :text, :string, limit: 255
  end
end

