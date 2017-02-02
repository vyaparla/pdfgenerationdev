module Report
  class RowFormatter
    def initialize
      @rows = []
    end

    def []=(row_i, options)
      @rows << [row_i, options]
    end

    def rows
      @rows
    end
  end
end
