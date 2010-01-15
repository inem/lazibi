require File.dirname(__FILE__) + '/filter_spec_helper'

module Lazibi
  module Spec
    describe 'OptionalDoFilter' do
      before(:all) do
        @f = OptionalDo.new
        @beautify = Beautify.new
        @optional_end = OptionalEnd.new

        # load fixtures
        @rbs = {}
        @metas = {}


        rb_dir = FIXTURE_DIR + '/optional_do/rbs'
        Dir.open(rb_dir).each do |fn|
          next unless fn =~ /[.]txt$/
          @rbs[fn.scan(/(.*)[.]/).to_s.to_sym] = File.read(rb_dir + "/#{fn}")
        end

        meta_dir = FIXTURE_DIR + '/optional_do/metas'
        Dir.open(meta_dir).each do |fn|
          next unless fn =~ /[.]txt$/
          @metas[fn.scan(/(.*)[.]/).to_s.to_sym] = File.read(meta_dir + "/#{fn}")
        end
      end

      it 'should remove do test drive' do
        @f.up('it do').should == 'it'
        @f.down("it\n  abc").should == "it do\n  abc"
      end


      it 'should integrate with beautify and optional_end' do
        list = [:classical, :lambda, :brackets_block, :describe, :do_block, :square_brackets]
        list.each do |name|
          assert_integrate name
        end
      end

      def assert_integrate(name, debug = false)
        code = @rbs[name]
        code = @beautify.up(code)
        code = @optional_end.up(code)
        code = @f.up(code)
        code.should == @metas[name]

        code = @metas[name]
        code = @f.down(code)
        code = @optional_end.down(code)
        code.should == @rbs[name]
      end
    end
  end
end