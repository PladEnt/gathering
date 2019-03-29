class Page < ActiveRecord::Base
    belongs_to :user
    has_many  :comments

    validates :title, presence:true
end
