class Repo < ApplicationRecord
  validates :name, presence: true
  validates :url, presence: true
  validates :git_date, presence: true

  belongs_to :profile
  has_many :repo_languages, dependent: :destroy
  has_many :languages, through: :repo_languages

  def languages_with_weight
    calc_languages_total_aamount
    calc_languages_weight

    wiegths
  end

  private

  attr_accessor :languages_total_amount, :wiegths

  def calc_languages_total_aamount
    self.languages_total_amount = languages.pluck(:amount).sum.to_f
  end

  def calc_languages_weight
    self.wiegths = {}

    languages.each { |language| wiegths[language.name] = (language.amount.to_f / languages_total_amount).round(5) }
  end
end
