# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'Convert factory_girl to factory_bot' do
  let(:rewriter_name) { 'factory_bot/convert_factory_girl_to_factory_bot' }

  context 'spec_helper' do
    let(:fake_file_path) { 'spec/spec_helepr.rb' }
    let(:test_content) { <<~EOS }
      RSpec.configure do |config|
        config.include FactoryGirl::Syntax::Methods
      end
    EOS

    let(:test_rewritten_content) { <<~EOS }
      RSpec.configure do |config|
        config.include FactoryBot::Syntax::Methods
      end
    EOS

    include_examples 'convertable'
  end

  context 'factory definition' do
    let(:fake_file_path) { 'spec/factories/user.rb' }
    let(:test_content) { <<~EOS }
      FactoryGirl.define do
        factory :user do
          email { Faker::Internet.email }
          username Faker::Name.first_name.downcase
          password "Sample:1"
          password_confirmation "Sample:1"
        end
      end
    EOS

    let(:test_rewritten_content) { <<~EOS }
      FactoryBot.define do
        factory :user do
          email { Faker::Internet.email }
          username Faker::Name.first_name.downcase
          password "Sample:1"
          password_confirmation "Sample:1"
        end
      end
    EOS

    include_examples 'convertable'
  end

  context 'factory usage' do
    let(:fake_file_path) { 'spec/models/user_spec.rb' }
    let(:test_content) { 'user = FactoryGirl.create(:user)' }
    let(:test_rewritten_content) { 'user = FactoryBot.create(:user)' }

    include_examples 'convertable'
  end

  context 'require factory' do
    let(:fake_file_path) { 'spec/rails_helper.rb' }
    let(:test_content) { <<~EOS }
      require 'factory_girl'
      require 'factory_girl_rails'
    EOS

    let(:test_rewritten_content) { <<~EOS }
      require 'factory_bot'
      require 'factory_bot_rails'
    EOS

    include_examples 'convertable'
  end
end
