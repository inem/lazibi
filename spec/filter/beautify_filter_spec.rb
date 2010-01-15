require File.dirname(__FILE__) + '/filter_spec_helper'

module Lazibi
  module Spec
    describe 'BeautifyFilter' do
      before(:all) do
        @f = Beautify.new

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

        @rbs = {}
        @metas = {}


        rb_dir = FIXTURE_DIR + '/beautify/rbs'
        Dir.open(rb_dir).each do |fn|
          next unless fn =~ /[.]txt$/
          @rbs[fn.scan(/(.*)[.]/).to_s.to_sym] = File.read(rb_dir + "/#{fn}")
        end

        meta_dir = FIXTURE_DIR + '/beautify/metas'
        Dir.open(meta_dir).each do |fn|
          next unless fn =~ /[.]txt$/
          @metas[fn.scan(/(.*)[.]/).to_s.to_sym] = File.read(meta_dir + "/#{fn}")
        end
      end

      it "should beautify public" do
        @p_metas.keys.each do |k|
          @f.up(@p_rbs[k]).should == @p_metas[k]
        end
      end

      it 'should clean str.gsub(/([^ \/a-zA-Z0-9_.-])/n)' do
        @f.clean_line('str.gsub(/([^ \/a-zA-Z0-9_.-])/n)').should == 'str.gsub(//n)'
      end

      it 'should clean %r{\A#{Regexp.escape(expanded_root)}(/|\\)}' do
        @f.clean_line('%r{\A#{Regexp.escape(expanded_root)}(/|\\)}').should == "''"
      end

      it 'should beautify' do
        @metas.keys.each do |k|
          @f.up(@rbs[k]).should == @metas[k]
        end
      end
    end
  end
end