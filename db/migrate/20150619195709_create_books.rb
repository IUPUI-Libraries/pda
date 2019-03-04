class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :author
      t.string :title
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
