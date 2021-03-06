# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'RSpec use new config options' do
  let(:rewriter_name) { 'rspec/new_config_options' }
  let(:fake_file_path) { 'spec/spec_helper.rb' }
  let(:test_content) { <<~EOS }
    RSpec.configure do |config|
      config.treat_symbols_as_metadata_keys_with_true_values = true

      config.backtrace_clean_patterns
      config.backtrace_clean_patterns = ["lib/something"]
      config.color_enabled = true

      config.out
      config.out = File.open("output.txt", "w")
      config.output
      config.output = File.open("output.txt", "w")

      config.backtrace_cleaner
      config.color?(output)
      config.filename_pattern
      config.filename_pattern = "**/*_test.rb"
      config.warnings
    end
  EOS

  let(:test_rewritten_content) { <<~EOS }
    RSpec.configure do |config|

      config.backtrace_exclusion_patterns
      config.backtrace_exclusion_patterns = ["lib/something"]
      config.color = true

      config.output_stream
      config.output_stream = File.open("output.txt", "w")
      config.output_stream
      config.output_stream = File.open("output.txt", "w")

      config.backtrace_formatter
      config.color_enabled?(output)
      config.pattern
      config.pattern = "**/*_test.rb"
      config.warnings?
    end
  EOS

  include_examples 'convertable'
end
