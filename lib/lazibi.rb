require 'fileutils'
require 'find'
require 'yaml'
require 'task'
require 'lazibi/version'

module Lazibi
  class Runner
    include Task
    attr :config

    def run
      puts '-' * 40
      load_config
      init_meta
      @metas = {}
      while true
        current_metas = get_metas
        current_metas.each_pair do |meta, m_time|
          if @metas[meta] != m_time
            update_rb meta
            puts "+ #{meta}..."
          end
        end
        @metas = current_metas
        sleep 1
      end
    end
  end
end