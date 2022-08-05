class RepoLanguage < ApplicationRecord
  belongs_to :repo
  belongs_to :language
end
