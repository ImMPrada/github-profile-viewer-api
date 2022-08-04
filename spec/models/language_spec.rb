require 'rails_helper'

RSpec.describe Language, type: :model do
  describe 'associations' do
    it { should have_many(:repo_languages) }
    it { should have_many(:repos) }
    it { should have_many(:profile_languages) }
    it { should have_many(:profiles) }
  end
end
