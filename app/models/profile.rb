class Profile < ApplicationRecord
  validates :nickname, presence: true, uniqueness: true
  validates :avatar, presence: true
  validates :url, presence: true
  validates :public_repos_count, presence: true
  validates :public_gists_count, presence: true
  validates :followers_count, presence: true
  validates :followings_count, presence: true
  validates :git_date, presence: true

  belongs_to :location

  has_many :repos, dependent: :destroy
  has_many :profile_languages, dependent: :destroy
  has_many :languages, through: :profile_languages

  def languages_with_weight
    list_languages
    calc_languages_total_aamount
    calc_languages_weight

    languages_weight
  end

  private

  attr_accessor :languages_total_amount, :language_list, :languages_weight

  def list_languages
    self.language_list = languages.pluck(:name).uniq
  end

  def calc_languages_total_aamount
    self.languages_total_amount = languages.pluck(:amount).sum.to_f
  end

  def calc_languages_weight
    self.languages_weight = {}

    language_list.each do |language|
      language_total_amount = languages.where(name: language).sum(:amount).to_f
      languages_weight[language] = (language_total_amount / languages_total_amount).round(5)
    end
  end
end
