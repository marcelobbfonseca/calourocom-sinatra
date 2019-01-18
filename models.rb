class User < ActiveRecord::Base
    has_many :answers
    has_many :posts
    has_many :comments
end

class Post < ActiveRecord::Base
    belongs_to :user
    belongs_to :institute
    has_many :answers
    has_many :comments, as: :commentable
end

class Answer < ActiveRecord::Base
    belongs_to :user
    belongs_to :post
    has_many :comments, as: :commentable
end

class Comment < ActiveRecord::Base
    belongs_to :user
end

class Institute < ActiveRecord::Base
    has_many :posts
end

class Tag < ActiveRecord::Base
end
