require 'rails_helper'

RSpec.describe ProfileLanguage, type: :model do
  describe 'associations' do
    it { should belong_to(:profile) }
    it { should belong_to(:language) }
  end
end
