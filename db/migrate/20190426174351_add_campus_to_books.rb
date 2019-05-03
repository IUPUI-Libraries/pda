class AddCampusToBooks < ActiveRecord::Migration
  def change
    add_column :books, :campus, :string
  end
end
