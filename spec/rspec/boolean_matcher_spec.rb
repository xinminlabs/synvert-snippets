# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'RSpec converts boolean matcher' do
  let(:rewriter_name) { 'rspec/boolean_matcher' }
  let(:fake_file_path) { 'spec/models/post_spec.rb' }
  let(:test_content) { <<~EOS }
    describe Post do
      it 'case' do
        expect(obj).to be_true
        expect(obj).to be_false
      end
    end
  EOS

  let(:test_rewritten_content) { <<~EOS }
    describe Post do
      it 'case' do
        expect(obj).to be_truthy
        expect(obj).to be_falsey
      end
    end
  EOS

  include_examples 'convertable'
end
