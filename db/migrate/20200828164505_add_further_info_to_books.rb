class AddFurtherInfoToBooks < ActiveRecord::Migration
  def change
    add_column :books, :further_info, :text
  end
end
