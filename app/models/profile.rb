class Profile < ApplicationRecord
  validates_presence_of :nickname
  validates_presence_of :avatar
  validates_presence_of :url
  validates_presence_of :repos_url
  validates_presence_of :public_repos
  validates_presence_of :public_gists
  validates_presence_of :followers
  validates_presence_of :followings
  validates_presence_of :git_date

  validates :nickname, uniqueness: true

  belongs_to :location
  has_many :repos
  has_many :profile_languages, dependent: :destroy
  has_many :languages, through: :profile_languages
end
