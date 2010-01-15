require File.dirname(__FILE__) + '/../spec_helper'
require 'default_engine'

describe 'DefaultEngine' do
  include Helper::ApplicationHelper
  before(:each) do
    @e = DefaultEngine.new
  end

  it "should stack filters" do
    rb = "  def\n  it do\n    puts\n  end\nend"
    meta ="def\n  it\n    puts"
    rb_clean = "def\n  it do\n    puts\n  end\nend"
    @e.up(rb).should == meta
    @e.down(meta).should == rb_clean
  end

  it 'should skip' do
    rb = '<<-HERE abc HERE'
    @e.up(rb).should =~ /^#/
  end

  it 'should preserved skipped rb' do
    rb = '<<-HERE abc HERE'
    meta = @e.up(rb)
    @e.down(meta).should == rb
  end
end