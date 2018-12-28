class ChangeThreadToComment < ActiveRecord::Migration[5.2]
  def change
    rename_column :threads, :comment, :description
    rename_table :threads, :comments
  end
end
