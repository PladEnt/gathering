class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :page

    validates :content, presence:true
end
