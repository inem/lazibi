require File.dirname(__FILE__) + '/../spec_helper'
require 'beautify_engine'

describe 'BeautifyEngine' do
  before(:each) do
    @e = BeautifyEngine.new
  end

  it "should beautify" do
    @e.up('   def class; end').should == "def class; end\n"
  end
end