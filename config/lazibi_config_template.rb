module Lazibi
  class Config
    def filter_order
      [:syntax_guard, :beautify, :optional_end, :optional_do]
    end

    def exclude
      ['^vendor']
    end

    def filters
      {:optional_do => ['^spec'], :optional_end => ['']}
    end
  end
end