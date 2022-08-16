require 'rails_helper'

RSpec.describe ProfileLanguage, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:profile) }
    it { is_expected.to belong_to(:language) }
  end
end
