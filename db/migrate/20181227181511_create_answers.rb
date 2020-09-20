class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      # t.string :title
      t.text :description
      t.integer :relevance
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
