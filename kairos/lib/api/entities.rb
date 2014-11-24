module API
  module Entities
    class UserSafe < Grape::Entity
      expose :email
    end

    class UserBasic < UserSafe
      expose :id
    end

    class User < UserBasic
      expose :created_at
    end

    class UserLogin < User
      expose :authentication_token
    end

    class Activity < Grape::Entity
      expose :id
      expose :name
      expose :description
    end

    class Entry < Grape::Entity
      expose :id
      expose :date
      expose :user, using: Entities::UserBasic
      expose :activity, using: Entities::Activity
      expose :duration
      expose :group
      expose :project
      expose :issue
    end
  end
end