class CreateUsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |user|
      user.string :name
      user.string :email
      user.string :avatar, default: '/img/anonymous-female-icon-16.png'
      user.integer :points, default: 0
      user.string :wallet
      user.datetime :created_at
      user.datetime :updated_at
    end
  end
end
