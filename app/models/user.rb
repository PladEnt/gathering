class User < ActiveRecord::Base
  has_many  :comments
  has_many  :pages

  validates :username, uniqueness: true
  validates :email, uniqueness: true

  has_secure_password

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end
end