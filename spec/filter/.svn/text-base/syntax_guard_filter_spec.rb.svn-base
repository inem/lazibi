require File.dirname(__FILE__) + '/filter_spec_helper'

module Lazibi
  module Spec
    describe 'SyntaxGuardFilter' do
      before(:all) do
        @f = SyntaxGuard.new

        # load fixtures
        @p_rbs = {}
        @p_metas = {}


        expected_dir = FIXTURE_DIR + '/real'
        Dir.open(expected_dir).each do |fn|
          next unless fn =~ /[.]txt$/
          @p_rbs[fn.scan(/(.*)[.]/).to_s.to_sym] = File.read(expected_dir + "/#{fn}")
        end

        clean_dir = FIXTURE_DIR + '/clean'
        Dir.open(clean_dir).each do |fn|
          next unless fn =~ /[.]txt$/
          @p_metas[fn.scan(/(.*)[.]/).to_s.to_sym] = File.read(clean_dir + "/#{fn}")
        end
      end

      it 'should skip' do
        bad_examples = %w( eval_code here_doc single_method general_eval javascript strange_syntax_1 )
        bad_examples.each do |example|
          @f.up(@p_rbs[example.to_sym]).should be_false
        end
      end
    end
  end
end