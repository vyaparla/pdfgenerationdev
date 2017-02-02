module Report
  class TableFormatter
    def initialize
      @row_formatter = RowFormatter.new
      @cell_formatter = CellFormatter.new
    end

    def cell
      @cell_formatter
    end

    def format(table)
      @row_formatter.rows.each do |(row_i, options)|
        table.row(row_i).style(options)
      end
      @cell_formatter.cells.each do |((row_i, column_i), options)|
        table.row(row_i).column(column_i).style(options)
      end
    end

    def row
      @row_formatter
    end
  end
end
