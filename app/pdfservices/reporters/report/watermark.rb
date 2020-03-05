module Report
  class Watermark
  	def write(pdf)
      add_watermark(pdf)
    end

    
    def end_page(pdf)
      pdf.stamp_at "watermark", [100, 210] 
    end 
  private

    def add_watermark(pdf)
        pdf.create_stamp("watermark") do
        pdf.rotate(30, :origin => [-5, -5]) do
        pdf.font_size 80
        pdf.fill_color "d3d3d3"
        pdf.font("Helvetica") do
          pdf.draw_text "In Progress", :at => [-15, -3]
        end
        pdf.fill_color "000000"
        end
      end
      pdf.stamp_at "watermark", [100, 210] 
    end  
 
  end
end
