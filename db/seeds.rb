#   #   #   #   #
# run           #
# rake db:seed  #
#   #   #   #   #
# require ../models
users = [
  {name: 'Jon', wallet: '0x002945718140134Doe', email: 'e@example.com'},
  {name: 'Jane', wallet: '0x002001932211Toe', email: 'e@example.com'},
  {email: 'hello@hello.com'},
]

users.each do |user|
  User.create(user)
end