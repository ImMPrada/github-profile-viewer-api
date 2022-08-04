class Language < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :amount

  has_many :repo_languages, dependent: :destroy
  has_many :repos, through: :repo_languages
  has_many :profile_languages, dependent: :destroy
  has_many :profiles, through: :profile_languages
end
