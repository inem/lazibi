require 'filter_base'

module Lazibi
  module Filter
    class SyntaxGuard < FilterBase

      def valid?( line )
        not_supported = using_eval?(line) || here_doc?(line) || special_syntax(line)
        return !not_supported
      end

      def using_eval?( line )
        line =~ /\b(class|module|instance)_eval\b/
      end

      def here_doc?( line )
        line =~ /(=\s*<<)|(<<-)/
      end

      def special_syntax( line )
        patterns = [
          /:\[\]=/,
          /\beval\b/,
          /javascript_cdata/
        ]
        for p in patterns
          return true if line =~ p
        end

        false
      end

      def valid_before_clean?( line )
        r = line =~ /#\{[^\{]*#\{.*\}.*\}/
        r.nil?
      end

      def up( source )
        source = split_end(source)
        commentBlock = false
        multiLineStr = ""
        source.split("\n").each do |line|
          # combine continuing lines
          if(!(clean_line(line, true) =~ /\s*#/) && line =~ /[^\\]\\\s*$/)
            multiLineStr += line.sub(/^(.*)\\\s*$/,"\\1")
            next
          end

          # add final line
          if(multiLineStr.length > 0)
            multiLineStr += line.sub(/^(.*)\\\s*$/,"\\1")
          end

          tline = ((multiLineStr.length > 0)?multiLineStr:line).strip
          if(tline =~ /^=begin/)
            commentBlock = true
          elsif !commentBlock
            commentLine = (tline =~ /^#/)
            if(!commentLine)
              valid_before = valid_before_clean?( tline )
              tline = clean_line(tline)
              unless ( valid?(tline) && valid_before )
                puts '- ' + tline
                return false
              end
              multiLineStr = ""
            end
          end
          if(tline =~ /^=end/)
            commentBlock = false
          end
        end
        return source
      end
    end
  end
end