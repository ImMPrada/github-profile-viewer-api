require 'rails_helper'

RSpec.describe Github::RepoLanguagesConsumer do
  let(:repo_languages) { described_class.new('immprada', 'art_musseum') }

  describe 'when ApiClient code: 200' do
    let(:expected_response) do
      [
        {
          repo_name: 'art_musseum',
          name: 'JavaScript',
          amount: 19_098
        },
        {
          repo_name: 'art_musseum',
          name: 'SCSS',
          amount: 3_184
        },
        {
          repo_name: 'art_musseum',
          name: 'HTML',
          amount: 220
        }
      ]
    end

    before do
      profile_response = instance_double(
        Github::ApiClient,
        fetch_repo_languages: {},
        code: 200,
        body:
          {
            'JavaScript' => 19_098,
            'SCSS' => 3_184,
            'HTML' => 220
          }
      )
      allow(Github::ApiClient).to receive(:new).and_return(profile_response)
    end

    it 'returns right body class' do
      expect(repo_languages.call.class).to eq(Array)
    end

    it 'returns right body content' do
      expect(repo_languages.call).to eq(expected_response)
    end
  end

  describe 'when ApiClient code: 4XX' do
    let(:expected_response) { nil }

    before do
      profile_response = instance_double(
        Github::ApiClient,
        fetch_repo_languages: {},
        code: 403,
        body: nil
      )
      allow(Github::ApiClient).to receive(:new).and_return(profile_response)
    end

    it 'returns right body class' do
      expect(repo_languages.call.class).to eq(NilClass)
    end

    it 'returns right body content' do
      expect(repo_languages.call).to eq(expected_response)
    end
  end
end
