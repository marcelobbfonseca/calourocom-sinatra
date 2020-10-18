class CreateUsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, default: "calourocom@#{Random.rand(0..9999)}"
      t.string :email
      t.string :avatar, default: '/img/anonymous-female-icon-16.png'
      t.integer :points, default: 0
      t.string :wallet
      t.references :institute, foreign_key: true
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
