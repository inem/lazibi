require File.dirname(__FILE__) + '/spec_helper'

module Lazibi
  module Spec

    describe 'Lazibi' do
      before(:all) do
        @r = Lazibi::Runner.new
        @r.load_config
      end

      it 'should load default config' do
        @r.config[:exclude].should_not be_nil
      end

      it 'should skip vendor by default' do
        @r.skip_path?('meta/vendor').should == true
      end
    end
  end
end