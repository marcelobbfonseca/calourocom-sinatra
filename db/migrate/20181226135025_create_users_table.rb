class CreateUsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |user|
      user.string :name
      user.string :wallet
      user.string :email
      user.datetime :created_at
      user.datetime :updated_at
    end
  end
end
