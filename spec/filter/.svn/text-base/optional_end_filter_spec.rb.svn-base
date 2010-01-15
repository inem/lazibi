require File.dirname(__FILE__) + '/filter_spec_helper'

module Lazibi
  module Spec
    describe 'OptionalEndFilter' do
      before(:all) do
        @f = OptionalEnd.new

        # load fixtures
        @p_rbs = {}
        @p_metas = {}


        rb_dir = FIXTURE_DIR + '/real'
        Dir.open(rb_dir).each do |fn|
          next unless fn =~ /[.]txt$/
          @p_rbs[fn.scan(/(.*)[.]/).to_s.to_sym] = File.read(rb_dir + "/#{fn}")
        end

        meta_dir = FIXTURE_DIR + '/meta'
        Dir.open(meta_dir).each do |fn|
          next unless fn =~ /[.]txt$/
          @p_metas[fn.scan(/(.*)[.]/).to_s.to_sym] = File.read(meta_dir + "/#{fn}")

          @beautify = Beautify.new

          # load fixtures
          @rbs = {}
          @metas = {}
        end


        rb_dir = FIXTURE_DIR + '/optional_end/rbs'
        Dir.open(rb_dir).each do |fn|
          next unless fn =~ /[.]txt$/
          @rbs[fn.scan(/(.*)[.]/).to_s.to_sym] = File.read(rb_dir + "/#{fn}")
        end

        meta_dir = FIXTURE_DIR + '/optional_end/metas'
        Dir.open(meta_dir).each do |fn|
          next unless fn =~ /[.]txt$/
          @metas[fn.scan(/(.*)[.]/).to_s.to_sym] = File.read(meta_dir + "/#{fn}")
        end
      end


      it "should find end" do
        assert_find :basic_class, 0, 0
        assert_find :class_with_def, 0, 1
        assert_find :class_with_def, 0, 1
        assert_find :class_with_def, 2, 0, 1..-1
        assert_find :two_methods, 0, 3
        assert_find :two_methods, 2, 0, 1..-1
        assert_find :partial_method, 2, 0
        assert_find :middle, 0, 1
        assert_find :multi_blocks, 0, 7
      end

      it "should preserve" do
        @p_metas.keys.reject{|k| ['partial_method', 'inline_end', 'optional_do',
        'eval_code', 'here_doc', 'single_method', 'comment_after_end'].include? k.to_s }.each do |k|
          assert_preserve_p k
        end
      end


      it "should convert to rb" do
        assert_to_rb_p :partial_method
        assert_to_rb_p :eval_code
        assert_to_rb_p :comment_after_end, :comment_after_end_expected
      end

      it "should convert to meta" do
        assert_to_meta_p :inline_end
        assert_to_meta_p :comment_after_end
      end

      it "should ignore :do" do
        assert_preserve( :space_sep_do )
      end

      def assert_find( name, indent, end_i, range = nil )
        unless range
          @f.find_end(@p_metas[name].split("\n"), indent).should == end_i
        else
          @f.find_end(@p_metas[name].split("\n")[range], indent).should == end_i
        end
      end


      def assert_to_rb_p( name, name_2 = nil )
        name_2 = name unless name_2
        @f.down( @p_metas[name]).should == @p_rbs[name_2]
      end

      def assert_to_meta_p( name, name_2 = nil )
        name_2 = name unless name_2
        @f.up( @p_rbs[name]).should == @p_metas[name_2]
      end

      def assert_preserve_p( name )
        assert_to_rb_p(name)
        assert_to_meta_p(name)
      end

      def assert_to_rb( name, name_2 = nil )
        name_2 = name unless name_2
        @f.down( @metas[name]).should == @rbs[name_2]
      end

      def assert_to_meta( name, name_2 = nil )
        name_2 = name unless name_2
        @f.up( @rbs[name]).should == @metas[name_2]
      end

      def assert_preserve( name )
        assert_to_rb(name)
        assert_to_meta(name)
      end
    end
  end
end