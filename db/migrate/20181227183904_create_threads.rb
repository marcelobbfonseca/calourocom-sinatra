class CreateThreads < ActiveRecord::Migration[5.2]
  def change
    create_table :threads do |t|
      t.string :comment
      t.integer :relevance
      t.references :answer, :post, polymorphic: true
      
    end
  end
end
