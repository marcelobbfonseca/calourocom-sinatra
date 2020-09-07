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
tags = [
  {name: 'UnB', color: 'blue' },
  {name: 'Mestrado', color: 'green' },
  {name: 'TCC', color: 'green' },
  {name: 'Carreira', color: 'green' },
  {name: 'CSF', color: 'green' },
  {name: 'Graduação', color: 'green' },
  {name: 'Design', color: 'green' },
  {name: 'Engenharia', color: 'green' },
]


Institute.create({name:"Universidade de Brasilia",description: "UnB - Universidade de Brasilia",category: :federal, image_file:'https://pt.wikipedia.org/wiki/Universidade_de_Bras%C3%ADlia#/media/Ficheiro:Webysther_20160322_-_Logo_UnB_(sem_texto).svg'})

tags.each do |tag|
  Tag.find_or_create_by(tag)
end


# users.each do |user|
#   User.create(user)
# end