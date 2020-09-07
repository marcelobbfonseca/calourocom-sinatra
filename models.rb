class User < ActiveRecord::Base
    has_many :answers
    has_many :posts
    has_many :comments
    enum role: { user: 0, admin: 1, service: 2}
end

class Post < ActiveRecord::Base
    belongs_to :user
    belongs_to :institute
    has_many :answers
    has_many :comments, as: :commentable
    has_many :posts_tags
    has_many :tags, through: :posts_tags
end

class Answer < ActiveRecord::Base
    belongs_to :user
    belongs_to :post
    has_many :comments, as: :commentable
end

class Comment < ActiveRecord::Base
    belongs_to :commentable, polymorphic: true
    belongs_to :user
end

class Institute < ActiveRecord::Base
    has_many :posts
    enum category: { private_institute: 0, federal: 1, state:2 }
end

class Tag < ActiveRecord::Base
    has_many :posts_tags
    has_many :posts, through: :posts_tags
end

class PostsTag < ActiveRecord::Base
    belongs_to :tag
    belongs_to :post
end