# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'FactoryBot uses short synax' do
  let(:rewriter_name) { 'factory_bot/use_short_syntax' }

  context 'rspec' do
    context 'spec_helper' do
      let(:fake_file_path) { 'spec/spec_helper.rb' }
      let(:test_content) { <<~EOS }
        RSpec.configure do |config|
          config.treat_symbols_as_metadata_keys_with_true_values = true
          config.run_all_when_everything_filtered = true
        end
      EOS

      let(:test_rewritten_content) { <<~EOS }
        RSpec.configure do |config|
          config.include FactoryBot::Syntax::Methods
          config.treat_symbols_as_metadata_keys_with_true_values = true
          config.run_all_when_everything_filtered = true
        end
      EOS

      include_examples 'convertable'
    end

    context 'unit test' do
      let(:fake_file_path) { 'spec/models/post_spec.rb' }
      let(:test_content) { <<~EOS }
        describe Post do
          it "tests post" do
            post1 = FactoryBot.create(:post)
            post2 = FactoryBot.build(:post)
            post_attributes = FactoryBot.attributes_for(:post)
            post3 = FactoryBot.build_stubbed(:post)
            posts1 = FactoryBot.create_list(:post, 2)
            posts2 = FactoryBot.build_list(:post, 2)
            posts3 = FactoryBot.create_pair(:post)
            posts4 = FactoryBot.build_pair(:post)
          end
        end
      EOS

      let(:test_rewritten_content) { <<~EOS }
        describe Post do
          it "tests post" do
            post1 = create(:post)
            post2 = build(:post)
            post_attributes = attributes_for(:post)
            post3 = build_stubbed(:post)
            posts1 = create_list(:post, 2)
            posts2 = build_list(:post, 2)
            posts3 = create_pair(:post)
            posts4 = build_pair(:post)
          end
        end
      EOS

      include_examples 'convertable'
    end
  end

  context 'test/unit' do
    context 'test_helper' do
      let(:fake_file_path) { 'test/test_helper.rb' }
      let(:test_content) { <<~EOS }
        class ActiveSupport::TestCase
        end
      EOS

      let(:test_rewritten_content) { <<~EOS }
        class ActiveSupport::TestCase
          include FactoryBot::Syntax::Methods
        end
      EOS

      include_examples 'convertable'
    end

    context 'unit test' do
      let(:fake_file_path) { 'test/unit/post_test.rb' }
      let(:test_content) { <<~EOS }
        test "post" do
          post1 = FactoryBot.create(:post)
          post2 = FactoryBot.build(:post)
          post_attributes = FactoryBot.attributes_for(:post)
          post3 = FactoryBot.build_stubbed(:post)
          posts1 = FactoryBot.create_list(:post, 2)
          posts2 = FactoryBot.build_list(:post, 2)
          posts3 = FactoryBot.create_pair(:post)
          posts4 = FactoryBot.build_pair(:post)
        end
      EOS

      let(:test_rewritten_content) { <<~EOS }
        test "post" do
          post1 = create(:post)
          post2 = build(:post)
          post_attributes = attributes_for(:post)
          post3 = build_stubbed(:post)
          posts1 = create_list(:post, 2)
          posts2 = build_list(:post, 2)
          posts3 = create_pair(:post)
          posts4 = build_pair(:post)
        end
      EOS

      include_examples 'convertable'
    end
  end

  context 'cucumber' do
    context 'features/support/env' do
      let(:fake_file_path) { 'features/support/env.rb' }
      let(:test_content) { <<~EOS }
        require "cucumber/rails"
      EOS

      let(:test_rewritten_content) { <<~EOS }
        require "cucumber/rails"
        World(FactoryBot::Syntax::Methods)
      EOS

      include_examples 'convertable'
    end

    context 'step definition' do
      let(:fake_file_path) { 'features/step_definitions/post_steps.rb' }
      let(:test_content) { <<~EOS }
        test "post" do
          post1 = FactoryBot.create(:post)
          post2 = FactoryBot.build(:post)
          post_attributes = FactoryBot.attributes_for(:post)
          post3 = FactoryBot.build_stubbed(:post)
          posts1 = FactoryBot.create_list(:post, 2)
          posts2 = FactoryBot.build_list(:post, 2)
          posts3 = FactoryBot.create_pair(:post)
          posts4 = FactoryBot.build_pair(:post)
        end
      EOS

      let(:test_rewritten_content) { <<~EOS }
        test "post" do
          post1 = create(:post)
          post2 = build(:post)
          post_attributes = attributes_for(:post)
          post3 = build_stubbed(:post)
          posts1 = create_list(:post, 2)
          posts2 = build_list(:post, 2)
          posts3 = create_pair(:post)
          posts4 = build_pair(:post)
        end
      EOS

      include_examples 'convertable'
    end
  end
end
