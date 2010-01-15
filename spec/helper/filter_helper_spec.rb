require File.dirname(__FILE__) + '/../spec_helper'
require 'beautify_filter'

include Filter

module Lazibi
  module Spec

    describe 'FilterHelper' do
      include Helper::FilterHelper
      it 'should detect start anchor' do
        start_anchor?( 'class' ).should == true
        start_anchor?( 'do |abc| ').should == true
        start_anchor?( 'do    |abc,def| ').should == true
        start_anchor?( '"abc do "').should == false
        start_anchor?( '"abc do  |"').should == false
        start_anchor?( 'lambda').should == false
      end

      it 'should detect end anchor' do
        end_anchor?( 'lambda' ).should == false
      end

      it 'should detect middle anchor' do
        middle_anchor?( '' ).should == false
        middle_anchor?( 'rescue' ).should == true
        middle_anchor?( 'lambda').should == false
      end

      it 'should detect comment at end' do
        comment_at_end('  dab #abcd').should_not be_nil
      end
    end
  end
end