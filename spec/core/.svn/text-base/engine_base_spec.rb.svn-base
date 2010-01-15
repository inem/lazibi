require File.dirname(__FILE__) + '/../spec_helper'
require 'engine_base'

describe 'EngineBase' do
  before(:each) do
    @e = EngineBase.new
  end

  it "should be able to go_up" do
    @e.go_up(:beautify)
    @e.up('  def;end').should == "def;end\n"
  end

  it "should stack filters" do
    rb = "  def\n  it do\n    puts\n  end\nend"
    meta ="def\n  it\n    puts"
    rb_clean = "def\n  it do\n    puts\n  end\nend"
    @e.go_up(:beautify, :optional_end, :optional_do)
    @e.up(rb).should == meta
    @e.go_down(:optional_do, :optional_end)
    @e.down(meta).should == rb_clean
  end
end