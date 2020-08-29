class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :description
      t.integer :relevance
      t.references :commentable, polymorphic: true
      t.references :user, foreign_key: true
      
    end
  end
end
