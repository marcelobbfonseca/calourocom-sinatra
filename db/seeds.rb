#   #   #   #   #
# run           #
# rake db:seed  #
#   #   #   #   #
# require ../models
users = [
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
  {name: 'Exatas', color: 'green' },
]
# User.find_or_create_by(email: 'hello@hello.com', name:'Hello World', role: 0)
User.find_or_create_by(email: 'calourocom@calourocom', name:'Anonimo', role: 0)

unb = Institute.find_or_create_by({name:"Universidade de Brasilia",description: "UnB - Universidade de Brasilia",category: :federal, image_file:'https://pt.wikipedia.org/wiki/Universidade_de_Bras%C3%ADlia#/media/Ficheiro:Webysther_20160322_-_Logo_UnB_(sem_texto).svg'})
user = User.find_or_create_by(name: 'Dinesh', email: 'dinesh@piper.com', role: 0)
john = User.find_or_create_by(name: 'John Snow', wallet: '0x002945718140134Doe', email: 'e@example.com')

post = Post.find_or_create_by(title: 'Ciencia da Computação', relevance:0, user_id:user.id, institute_id:unb.id)
answer = Answer.find_or_create_by(description: 'Aonde encontro oportunidades de estágio?',relevance: 0,user_id: john.id,post_id: post.id)
Comment.create(description:'Obrigado pela dica!', relevance:0, commentable:answer, user_id:user.id )
Comment.create(description:'Obrigado pela dica!', relevance:0, commentable:post, user_id:john.id )

tags.each do |tag|
  Tag.find_or_create_by(tag)
end
post.tags = [Tag.first,Tag.second,Tag.last]
post.save
