module Report
  module PhotoPageWritable
  	include PageWritable

    private   

      def relative_background_path
        'three_hundred_dpi/final_graphic_page.jpg'
      end
  end
end