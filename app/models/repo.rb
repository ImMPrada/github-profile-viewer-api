class Repo < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :url
  validates_presence_of :description
  validates_presence_of :languages_url
  validates_presence_of :git_date

  belongs_to :profile
  has_many :repo_languages, dependent: :destroy
  has_many :languages, through: :repo_languages
end
