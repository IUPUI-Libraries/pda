class AddIucatToBook < ActiveRecord::Migration
  def change
    add_column :books, :iucat, :string
  end
end
