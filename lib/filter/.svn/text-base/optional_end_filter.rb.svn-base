require 'filter_base'

module Lazibi
  module Filter
    class OptionalEnd < FilterBase

      def up( source )
        rb = source
        py = []
        lines = rb.split("\n")
        lines.each_index do |index|
          l = lines[index]
          if l.strip =~ /^end$/
            next
          end
          l = remove_colon_at_end(l)

          s = l
          if comment_at_end(l)
            s = s.sub(/(\s*;\s*end*\s*)(#.*)/, ' \2')
            s = s.sub(/(\s+end*\s*)(#.*)/, ' \2')
          else
            s = s.sub(/\s+end\s*$/, '')
            s = remove_colon_at_end(s)
          end

          py << s
        end

        py.join("\n")
      end


      def remove_colon_at_end(l)
        if comment_at_end(l)
          l.sub /(\s*;\s*)(#.*)/, ' \2'
        else
          l.sub /;*$/, ''
        end
      end

      def down( source )
        content = source
        return '' if content.strip == ''
        lines = content.split("\n")
        first_line = lines.first.strip
        return lines[1..-1].join("\n") if first_line == '#skip_parse'
        insert_end content
      end

      def insert_end( content )
        @lines = content.split("\n")
        progress = 0
        while progress < @lines.size
          lines = @lines[progress..-1]
          lines.each_index do |index|
            l = lines[index]
            safe_l = clean_block(clean_line(get_rest(l)))
            if start_anchor? safe_l
              relative_index_for_end = find_end( lines[index..-1], get_indent(l))
              unless relative_index_for_end
                progress += 1
                break
              end
              index_for_end = relative_index_for_end + index

              if relative_index_for_end == 0 && !comment_at_end(l)
                #l = lines[index_for_end]
                lines[index_for_end] = lines[index_for_end].rstrip + '; end'
              else
                lines[index_for_end] = lines[index_for_end] + "\n" +  ' ' * get_indent(l) + "end"
              end
              head = @lines[0...progress]
              tail = lines[index..-1].join("\n").split("\n")

              @lines = head + tail


              progress += 1
              break
            end
            progress += 1
          end
        end

        result = @lines.join("\n")
      end

      def find_end( lines, indent )
        return 0 if lines.size == 1

        anchor = 0

        lines = lines[1..-1]
        lines.each_index do |i|
          l = lines[i]
          next if l.strip == ''
          if l.strip =~ /^#/
            if get_indent(l) > indent
              anchor = i + 1
            end
            next
          end
          return anchor if get_indent(l) < indent
          if get_indent(l) == indent
            rest = get_rest l
            if start_anchor? rest
              return anchor
            elsif end_anchor? rest
              return false
            elsif middle_anchor? rest
              anchor = i + 1
              next
            else
              return anchor
            end
          end
          anchor =  i + 1
        end
        return anchor
      end
    end
  end
end