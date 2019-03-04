class AddPurchaseToBooks < ActiveRecord::Migration
  def change
    add_column :books, :purchase, :string
  end
end
