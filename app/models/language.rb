class Language < ApplicationRecord
  validates :name, presence: true
  validates :amount, presence: true

  has_many :repo_languages, dependent: :destroy
  has_many :repos, through: :repo_languages
  has_many :profile_languages, dependent: :destroy
  has_many :profiles, through: :profile_languages

  def self.amounts_by_language
    group(:name).sum(:amount)
  end

  def self.total_amount
    sum(:amount)
  end

  def self.weights_by_language
    weights = {}
    total_amount = self.total_amount

    amounts_by_language.each do |language, amount|
      weights[language] = (amount.to_f / total_amount).round(5)
    end

    weights
  end
end
