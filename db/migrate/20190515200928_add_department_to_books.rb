class AddDepartmentToBooks < ActiveRecord::Migration
  def change
    add_column :books, :department, :string
  end
end
