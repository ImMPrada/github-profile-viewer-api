class Language < ApplicationRecord
  validates :name, presence: true
  validates :amount, presence: true

  has_many :repo_languages, dependent: :destroy
  has_many :repos, through: :repo_languages
  has_many :profile_languages, dependent: :destroy
  has_many :profiles, through: :profile_languages
end
