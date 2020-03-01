class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |tag|
      tag.string :name
      tag.string :color
      tag.datetime :created_at
      tag.datetime :updated_at
    end
  end
end
