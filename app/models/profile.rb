class Profile < ApplicationRecord
  validates :nickname, presence: true, uniqueness: true
  validates :avatar, presence: true
  validates :url, presence: true
  validates :repos_url, presence: true
  validates :public_repos_count, presence: true
  validates :public_gists_count, presence: true
  validates :followers_count, presence: true
  validates :followings_count, presence: true
  validates :git_date, presence: true

  belongs_to :location

  has_many :repos, dependent: :destroy
  has_many :profile_languages, dependent: :destroy
  has_many :languages, through: :profile_languages
end
