require 'filter_base'

module Lazibi
  module Filter
    class OptionalDo < FilterBase
      def up(source)
        lines = source.split("\n")
        lines.each_index do |index|
          l = lines[index]
          l = optional_do_filter_to_py( lines, index )
          lines[index] = l
        end
        lines.join "\n"
      end

      def optional_do_filter_to_py(lines, index)
        l = lines[index]
        return l if l.strip == ''
        return l if l.strip[0..0] == '#'
        l_check = clean_line(l).strip
        if l_check.size > 2 && l.strip[-3..-1] == ' do' && !nasty_line?(l_check)
          l = l.rstrip[0...-3].rstrip
          return l
        end
        return l
      end


      def down(source)
        lines = source.split("\n")
        lines.each_index do |index|
          l = lines[index]
          l = optional_do_filter_to_rb(lines, index)
          lines[index] = l
        end
        lines.join "\n"
      end

      def optional_do_filter_to_rb(lines, index)
        l = lines[index]
        return l if l.strip == ''
        return l if l =~ /[\{\[]\s*$/
        rest = get_rest(l)
        return l if start_anchor?(rest) || middle_anchor?(rest) || end_anchor?(rest)

        l_check = clean_line l
        next_line = ''
        if index + 1 < lines.size
          lines[index+1..-1].each_index do |i|
            abs_i = index + 1 + i
            next if lines[abs_i].strip == ''
            next_line = lines[abs_i]
            break
          end
        else
          return l
        end
        if get_indent(next_line) > get_indent(l)
          return l.rstrip + ' do'
        else
          return l
        end
      end
    end
  end
end