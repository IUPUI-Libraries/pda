class AddCourseToBooks < ActiveRecord::Migration
  def change
    add_column :books, :course, :boolean, default: false
  end
end
