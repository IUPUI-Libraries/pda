class AddPubToBook < ActiveRecord::Migration
  def change
    add_column :books, :pub, :string
  end
end
