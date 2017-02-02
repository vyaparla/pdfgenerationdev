module Report
  class CellFormatter
    def initialize
      @cells = []
    end

    def []=(row_i, column_i, options)
      @cells << [[row_i, column_i], options]
    end

    def cells
      @cells
    end
  end
end