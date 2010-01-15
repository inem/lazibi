require 'beautify_engine'

module Lazibi
  class DefaultEngine < BeautifyEngine
    def initialize
      super
      go_up :optional_end, :optional_do
      go_down :optional_do, :optional_end
    end
  end
end