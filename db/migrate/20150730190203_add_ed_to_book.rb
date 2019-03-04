class AddEdToBook < ActiveRecord::Migration
  def change
    add_column :books, :ed, :string
  end
end
