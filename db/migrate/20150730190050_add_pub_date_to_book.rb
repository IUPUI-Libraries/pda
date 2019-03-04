class AddPubDateToBook < ActiveRecord::Migration
  def change
    add_column :books, :pub_date, :string
  end
end
