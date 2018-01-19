module Report
  module PageWritable
  	def write(pdf)
      start_new_page(pdf)
    end

  private

    def background_path
      return unless respond_to?(:relative_background_path, true)
      "#{Rails.root}/lib/pdf_generation/report_assets/" + relative_background_path
    end

    def bottom_margin; end

    def draw_background(pdf)
      return unless background_path
      size = [612.0, 792.0]
      pdf.image background_path, :fit => size, :at  => [-pdf.bounds.absolute_left, size.last - pdf.bounds.absolute_bottom]
    end

    def start_new_page(pdf)
      pdf.start_new_page :bottom_margin => bottom_margin
      draw_background(pdf)

      string = "<page>"
      options = { :at => [pdf.bounds.right - 150, 130],
      :width => 170,
      :align => :right, :size => 11,
      :page_filter => (1),
      :start_count_at => 1,
      :color => "808080" }
      pdf.number_pages string, options
      options[:at] = [pdf.bounds.right - 150, 23]
      options[:page_filter] = lambda{ |pg| pg > 1 }
      options[:start_count_at] = 1
      pdf.number_pages string, options
    
      # pdf.number_pages "<page>",
      # {
      #   :start_count_at => 1,
      #   :page_filter => :all,
      #   :at => [pdf.bounds.right - 180, 50],
      #   :width => 170,
      #   :align => :right, :size => 11,
      #   :color => "808080"
      # }

      draw_heading(pdf) if respond_to?(:draw_heading, true)
    end
  end
end
