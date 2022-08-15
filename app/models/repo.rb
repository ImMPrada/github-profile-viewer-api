class Repo < ApplicationRecord
  validates :name, presence: true
  validates :url, presence: true
  validates :git_date, presence: true

  belongs_to :profile
  has_many :repo_languages, dependent: :destroy
  has_many :languages, through: :repo_languages
end
