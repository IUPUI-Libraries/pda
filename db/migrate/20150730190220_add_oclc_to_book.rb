class AddOclcToBook < ActiveRecord::Migration
  def change
    add_column :books, :oclc, :string
  end
end
