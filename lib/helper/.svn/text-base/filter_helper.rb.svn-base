module Lazibi
  module Helper
    module FilterHelper
      def get_indent( line )
        line =~ /( *)/
        $1.size
      end

      def get_rest( line )
        line =~/( *)/
        $'
      end

      def begin_keys
        [
          /^module\b/,
          /(=\s*|^|<<\s*)if\b/,
          /(=\s*|^|<<\s*)until\b/,
          /(=\s*|^|<<\s*)for\b/,
          /(=\s*|^|<<\s*)unless\b/,
          /(=\s*|^|<<\s*)while\b/,
          /(=\s*|^|<<\s*)begin\b/,
          /(=\s*|^|<<\s*)loop\b\s*do/,
          /\bcase\b/,
          /^class\b/,
          /^def\b/,
          /\sdo\b/,
          /^do\b/
        ]
      end

      def middle_keys
        [
          /^then\b/,
          /^else\b/,
          /^elsif\b/,
          /^ensure\b/,
          /^rescue\b/,
          /^when\b/
        ]
      end


      def end_keys
        /^end\b/
      end

      def start_anchor?( str )
        return false if str =~ /^#/
        str = clean_line str
        group_match str, begin_keys
      end

      def middle_anchor?( str )
        str = clean_line str
        group_match str, middle_keys
      end


      def group_match(str, patterns)
        for pattern in patterns
          return true if str =~ pattern
        end
        false
      end

      def end_anchor?(str)
        str =~ end_keys ? true : false
      end


      # why?
      def nasty_line?(line)
        return false
        s = %w! \/ ' " \( \{ \[ !
        p = Regexp.new(s.join('|'))
        return line =~ p
      end

      def comment_at_end(line)
        return false if line.strip ==''
        clean_line(line, true) =~ /#/
      end

      def clean_line( line, leave_comment = false )
        tline = line.dup.sub /[;]*$/, ''

        tline.gsub!(/#\{.*?\}/,"")
        tline.gsub!(/\\\"/,"'")

        # deal with nested syntax

        tline.gsub!(/"\/*?"/,"\"\"")
        tline.gsub!(/\/.*?[^\\]\//,"//")

        # again
        tline.gsub!(/".*?"/,"\"\"")
        tline.gsub!(/'.*?'/,"''")
        tline.gsub!(/`.*?`/,"''")

        # more ..
        tline.gsub!(/%[qwsrx]\{.*?\}/, "''")
        tline.gsub!(/%[qwsrx]\(.*?\)/, "''")
        tline.gsub!(/%[qwsrx]\[.*?\]/, "''")
        tline.gsub!(/%[qwsrx](.).*?\1/, "''")

        tline.gsub!(/#.*$/, '') unless leave_comment

        tline
      end


      def clean_block(line)
        line.gsub /do\b.*?;\s*end/, ''
      end

      def split_end( source )
        lines = source.split("\n")
        new_lines = []
        for line in lines
          if line =~ /^\s*#/
            new_lines << line
          elsif line =~ /^\s*end\./
            new_lines << line
          else
            new_lines << line.gsub( /\send\./, "\nend." )
          end
        end

        new_lines.join("\n")
      end
    end
  end
end