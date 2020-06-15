# require 'byebug'

class UserPolicy
    attr_reader :current_user, :profile_user
    def initialize(current_user, profile_user)
        @current_user = current_user
        @profile_user = profile_user
    end

    def edit?
        # byebug
        current_user.id == profile_user.id or current_user.admin?
    end
end


class PostPolicy
    attr_reader :user, :post
    def initialize(user, post)

    end

    def edit?
        user.id == post.user.id or user.admin?
    end
end

class AnswerPolicy
    attr_reader :user, :answer

    def initialize(user, answer)
    end

    def edit?
        user.id == answer.user.id or user.admin?
    end
end

class CommentPolicy
    attr_reader :user, :comment

    def initialize(user, comment)
    end

    def edit?
        user.id == comment.user.id or user.admin?
    end
end

class InstitutePolicy
    attr_reader :user, :institute

    def initialize(user, institute)
    end

    def edit?
        user.admin?
    end
end

class TagPolicy
    attr_reader :user, :tag

    def initialize(user, tag)
    end

    def edit?
        user.admin?
    end
end