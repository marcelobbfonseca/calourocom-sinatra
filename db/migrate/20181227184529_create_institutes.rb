class CreateInstitutes < ActiveRecord::Migration[5.2]
  def change
    create_table :institutes do |t|
      t.integer :category
      t.string :name
      t.string :description
      t.string :image_file
      t.datetime :created_at
      t.datetime :updated_at
    end

  end
end
