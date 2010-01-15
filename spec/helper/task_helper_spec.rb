require File.dirname(__FILE__) + '/../spec_helper'
require 'task_helper'

module Lazibi
  module Spec
    describe 'TaskHelper' do
      include Helper::TaskHelper

      it 'should test_convert_path' do
        convert_path( 'meta/abc.py.rb' ).should == 'real/abc.rb'
        convert_path( 'real/abc.rb' ).should == 'meta/abc.py.rb'
        convert_path( 'meta/lib/abc.py.rb' ).should == 'real/lib/abc.rb'
      end


      it 'should soft filters' do
        sort_filter([:optional_end, :optional_do, :beautify]).should == [:beautify, :optional_end, :optional_do]
      end
    end
  end
end