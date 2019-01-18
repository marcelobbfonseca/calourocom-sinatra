class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |tags|
      tags.string :name
      tags.datetime :created_at
      tags.datetime :updated_at
    end
  end
end
