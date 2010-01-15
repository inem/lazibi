require File.dirname(__FILE__) + '/../spec_helper'

filter_dir = File.dirname(__FILE__) + '/../../lib/filter/'
Dir.open(filter_dir).each do |fn|
  next unless fn =~ /[.]rb$/
  require fn
end

include Filter