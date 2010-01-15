# Ruby beautifier, version 1.3, 04/03/2006
# Copyright (c) 2006, P. Lutus
# TextMate modifications by T. Burks
# Released under the GPL
#
# Modified for lazibi filter by Jinjing

require 'filter_base'
require 'beautify_filter_helper'

module Lazibi
  module Filter
    class Beautify < FilterBase
      include Helper::BeautifyFilterHelper

      def make_tab(tab)
        return (tab < 0) ? "": tab_str * tab_size * tab
      end

      def add_line(line,tab)
        line.strip!
        line = make_tab(tab)+line if line.length > 0
        return line + "\n"
      end

      def join_sep_line( source )
        lines = source.split("\n")
        continue = false
        buffer = ''
        new_lines = []
        for line in lines
          if clean_line(line, true).strip =~ /#/
            if continue
              new_lines << buffer
              new_lines << line
              buffer = ''
            else
              new_lines << line
            end
            next
          end

          if continue
            if line.strip == ''
              continue = false
              new_lines << buffer
              new_lines << line
              buffer = ''
            elsif line.strip[-1..-1] == "\\"
              continue = true
              buffer += ' ' + line.strip[0...-1].strip
            else
              continue = false
              buffer += ' ' + line.lstrip
              new_lines << buffer
              buffer = ''
            end
          else
            if line.strip == ''
              new_lines << line
            elsif line.strip[-1..-1] == "\\"
              continue = true
              buffer += line.rstrip[0...-1].strip
            else
              new_lines << line
            end
          end
        end

        new_lines.join("\n")
      end

      def up( source )
        source = split_end(source)
        commentBlock = false
        multiLineArray = Array.new
        multiLineStr = ""
        tab = 0
        dest = ""
        source.split("\n").each do |line|
          # combine continuing lines
          if(!(clean_line(line, true) =~ /\s*#/) && line =~ /[^\\]\\\s*$/)
            multiLineArray.push line
            multiLineStr += line.sub(/^(.*)\\\s*$/,"\\1")
            next
          end

          # add final line
          if(multiLineStr.length > 0)
            multiLineArray.push line
            multiLineStr += line.sub(/^(.*)\\\s*$/,"\\1")
          end

          tline = ((multiLineStr.length > 0)?multiLineStr:line).strip
          if(tline =~ /^=begin/)
            commentBlock = true
          end
          if(commentBlock)
            # add the line unchanged
            dest += line + "\n"
          else
            commentLine = (tline =~ /^#/)
            if(!commentLine)
              # throw out sequences that will
              # only sow confusion
              tline = clean_line(tline)
              outdent_exp.each do |re|
                if(tline =~ re)
                  tab -= 1
                  break
                end
              end
            end
            if (multiLineArray.length > 0)
              first_line = true
              multiLineArray.each do |ml|
                if first_line
                  dest += add_line(ml,tab)
                  first_line = false
                elsif ml.strip =~ /^unless/ || ml.strip =~ /^if/
                  dest = dest.chop.rstrip.chop.rstrip + ' ' + ml.strip + "\n"
                else
                  dest += add_line(ml,tab)
                end
              end
              multiLineArray.clear
              multiLineStr = ""
            else
              dest += add_line(line,tab)
            end
            if(!commentLine)
              indent_exp.each do |re|
                if(tline =~ re) && !(tline =~ /\s+end\s*$/)
                  tab += 1
                  break
                end
              end
            end
          end
          if(tline =~ /^=end/)
            commentBlock = false
          end
        end
        dest
      end
    end
  end
end