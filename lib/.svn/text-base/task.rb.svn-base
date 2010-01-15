$:.unshift(File.dirname(__FILE__) + '/helper')
$:.unshift(File.dirname(__FILE__) + '/core')

require 'task_helper'
require 'beautify_engine'
require 'yaml'


module Lazibi
  module Task
    include Helper::TaskHelper

    def load_config
      @config = {}
      default = {:exclude => ['^vendor'], :filters => {:optional_do => ['^spec'], :optional_end => ['']}}
      config_path = File.join('real', 'config', 'lazibi_config.rb')
      unless File.exists? config_path
        config_dir = File.join('real', 'config')
        FileUtils.mkdir_p config_dir
        template_path = File.dirname(__FILE__) + '/../config/lazibi_config_template.rb'
        FileUtils.cp template_path, config_path
        puts 'created real/config/lazibi_config.rb'
      end

      puts 'loading lazibi_config.rb'
      sep_line
      require config_path
      config = Config.new
      for method in Config.instance_methods(false)
        m = method.to_sym
        @config[m] = config.send(m)
      end
    end


    def init_meta
      # backup real
      real_dir = 'real'
      if File.directory? real_dir
        backup_dir = '.backup'

        # backup is disabled for now, not useful :/
        unless File.exists? backup_dir || true
          puts "backup #{real_dir} to #{backup_dir}"
          sep_line
          FileUtils.cp_r real_dir, backup_dir
        end
      else
        raise 'No directory named "real"'
      end

      # generate meta
      meta_dir = 'meta'
      FileUtils.mkdir_p meta_dir
      if File.exists? meta_dir
        if File.directory? meta_dir
          FileUtils.rm_rf meta_dir
        else
          raise 'meta directory is reserved for instiki'
        end
      end


      puts "Generating meta files:"
      sep_line
      Dir.glob(File.join('real', '**', '*.rb')) do |f|
        if skip_path? f
          puts "- #{f}"
          next
        end

        next unless File.file? f
        next if f =~ /.*[.]py[.]rb$/
        py_path = convert_path f
        dir_name = File.dirname py_path

        puts '  ' + py_path
        FileUtils.mkdir_p dir_name
        make_py f, py_path
      end

      sep_line
    end

    def make_py( rb_path, py_path )
      rb = open(rb_path).read

      py_file = open(py_path, 'w')
      filters = get_filters(py_path)
      engine = BeautifyEngine.new
      engine.go_up(*filters)
      py = engine.up rb

      py_file.write(py)
      py_file.close
    end


    def update_rb( meta_name, filters = {} )
      meta = open(meta_name)
      real_name = convert_path meta_name
      begin
        real_path = File.dirname real_name
        FileUtils.mkdir_p real_path
        real_rb = open( real_name, 'w' )
        filters = get_filters(meta_name).reverse
        engine = BeautifyEngine.new
        engine.go_down(*filters)
        rb = engine.down meta.read
        real_rb.write(rb)
      rescue Exception => e
        puts e
      ensure
        real_rb.close unless real_rb.nil?
      end
      meta.close
    end


    def get_metas
      meta_files = File.join('meta', "**", "*.py.rb")
      metas = {}
      Dir.glob(meta_files).each do |t|
        metas[t] = File.mtime t
      end
      metas
    end
  end
end