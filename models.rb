class User < ActiveRecord::Base
    has_many :answers
    has_many :posts, inverse_of: :author
    has_many :comments
    belongs_to :institute
    enum role: { user: 0, admin: 1, service: 2}
end

class Post < ActiveRecord::Base
    belongs_to :author, class_name: 'User', foreign_key: 'user_id', inverse_of: :posts
    belongs_to :institute
    has_many :answers
    has_many :comments, as: :commentable
    has_many :posts_tags
    has_many :tags, through: :posts_tags
    default_scope { order(:relevance) }

    def answers_count
        self.answers.count
    end

end

class Answer < ActiveRecord::Base
    belongs_to :author, class_name: 'User', foreign_key: 'user_id', inverse_of: :posts
    belongs_to :post
    has_many :comments, as: :commentable 
    default_scope { order(:relevance) }
end

class Comment < ActiveRecord::Base
    belongs_to :commentable, polymorphic: true
    belongs_to :author, class_name: 'User', foreign_key: 'user_id', inverse_of: :posts
    default_scope { order(:relevance) }

end

class Institute < ActiveRecord::Base
    has_many :posts
    has_many :users
    enum category: { private_institute: 0, federal: 1, state:2 }
end

class Tag < ActiveRecord::Base
    has_many :posts_tags
    has_many :posts, through: :posts_tags
end

class PostsTag < ActiveRecord::Base
    belongs_to :tag
    belongs_to :post
    default_scope { order(:color) }
end