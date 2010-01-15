$:.unshift(File.dirname(__FILE__) + '/../filter')
$:.unshift(File.dirname(__FILE__) + '/../helper')

require 'rubygems'
require 'active_support'
require 'application_helper'

module Lazibi
  class EngineBase
    include Helper::ApplicationHelper

    attr :up_path
    attr :down_path
    attr :filters

    def initialize
      @filters = []
      @up_path = []
      @down_path = []
      filter_dir = File.dirname(__FILE__) + '/../filter'

      Dir.open(filter_dir).each do |fn|
        next unless fn =~ /[.]rb$/
        require fn
        @filters << fn.scan(/(.*)[.]/).to_s.to_sym
      end
    end


    def go_up(*paths)
      @up_path += Array(paths)
    end

    def go_down(*paths)
      @down_path += Array(paths)
    end

    def up(source)
      return source if source.blank?
      transcript = source
      valid = true
      @up_path.each do |step|
        class_name = step.to_s.camelize
        filter = Filter.const_get(class_name).new
        transcript = filter.up(transcript)
        unless transcript
          valid = false
          break
        end
      end

      valid ? transcript : skip_notice + "\n" + source
    end

    def down(source)
      return source if source.blank?
      transcript = source
      if transcript.split("\n").first == skip_notice
        return source.split("\n")[1..-1].join("\n")
      end

      @down_path.each do |step|
        class_name = step.to_s.camelize
        filter = Filter.const_get(class_name).new
        transcript = filter.down(transcript)
      end
      transcript
    end

    def to_s
      'up_path: ' + @up_path.to_s + "\n" + 'down_path: ' + @down_path.to_s
    end
  end
end