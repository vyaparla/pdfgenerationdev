module Report
  class Table
    def initialize(data)
      @data = data
    end

    def draw(pdf, &block)
      pdf.font_size 8
      pdf.table(@data, header: true) do |table|
        set_styling(table)
        set_column_widths(table)
        if block != nil
          formatter = TableFormatter.new
          block.call(formatter)
          formatter.format(table)
        end
      end
    end

  private

    def natural_column_widths(table)
      table.send(:natural_column_widths)
    end

    def normalized_column_width(table)
      table.width.to_f / table.column_length
    end

    def scale_factor(table)
      table.width / table.send(:natural_width)
    end

    def scaled_column_width(table, index)
      natural_column_widths(table)[index].to_f * scale_factor(table)
    end

    def set_column_widths(table)
      return unless table.send(:natural_width) > table.width
      table.column_widths = (0...table.column_length).map do
                              normalized_column_width(table)
                            end
    end

    def set_styling(table)
      table.rows(0...table.row_length).style border_width: 0.5
      table.row(0).style border_color:     '888888',
                         background_color: '444444',
                         text_color:       'ffffff'
      table.rows(1...table.row_length).style border_color: 'cccccc'
    end
  end
end
