module Lazibi
  module Helper
    module TaskHelper
      def skip_path?(path)
        return false if @config[:exclude].nil?
        @config[:exclude].each do |f|
          return true if original_path(path) =~ Regexp.new(f)
        end
        false
      end

      def convert_path( path )
        if path =~ /.*[.]py[.]rb/
          from = 'meta'
          to = 'real'
          old_ext = '.py.rb'
          new_ext = '.rb'
        else
          from = 'real'
          to = 'meta'
          old_ext = '.rb'
          new_ext = '.py.rb'
        end

        dir_name = File.dirname path
        base_name = File.basename path, old_ext

        new_dir_name = to + dir_name[from.size..-1]
        new_path = File.join new_dir_name, base_name + new_ext
      end

      def get_filters(path)
        filters = @config[:filters]
        return unless filters
        path_filters = []
        for filter in filters.keys
          path_patterns = filters[filter]
          for p in path_patterns
            if original_path(path) =~ Regexp.new(p)
              path_filters << filter.to_sym
              next
            end
          end
        end

        sort_filter path_filters
      end

      def sort_filter( filters )
        order = @config[:filter_order] if @config
        order = [:syntax_guard, :beautify, :optional_end, :optional_do] unless order
        filters.sort{ |a,b| order.index(a) <=> order.index(b) }
      end

      def original_path(path)
        offset = 'meta'.size + 1
        path[offset..-1]
      end

      def sep_line
        puts '-' * 40
      end
    end
  end
end