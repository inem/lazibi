module Lazibi
  module Helper
    module BeautifyFilterHelper
      def tab_size
        2
      end

      def tab_str
        " "
      end

      def indent_exp
        [
          /^module\b/,
          /(=\s*|^|<<\s*)if\b/,
          /(=\s*|^|<<\s*)until\b/,
          /(=\s*|^|<<\s*)for\b/,
          /(=\s*|^|<<\s*)unless\b/,
          /(=\s*|^|<<\s*)while\b/,
          /(=\s*|^|<<\s*)begin\b/,
          /(=\s*|^|<<\s*)loop\b/,
          #    /\bthen\b/,
          /\bcase\b/,
          /^class\b/,
          /^rescue\b/,
          /^def\b/,
          /\sdo\b/,
          /^else\b/,
          /^elsif\b/,
          /^ensure\b/,
          /\bwhen\b/,
          /\{[^\}]*$/,
          /\[[^\]]*$/
        ]
      end

      def outdent_exp
        [
          /^rescue\b/,
          /^ensure\b/,
          /^elsif\b/,
          #    /\bthen\b/,
          /^end\b/,
          /^else\b/,
          /\bwhen\b/,
          /^[^\{]*\}/,
          /^[^\[]*\]/
        ]
      end
    end
  end
end