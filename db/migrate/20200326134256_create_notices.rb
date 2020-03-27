class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.text :message
      t.boolean :display

      t.timestamps
    end
  end
end
