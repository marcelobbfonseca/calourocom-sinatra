class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |post|
      post.string :title 
      post.string :description 
      post.integer :relevance
      post.references :user, foreign_key: true
      post.datetime :created_at
      post.datetime :updated_at
    end
  end
end
