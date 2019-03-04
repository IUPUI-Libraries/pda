class AddUtitleToBook < ActiveRecord::Migration
  def change
    add_column :books, :utitle, :string
  end
end
