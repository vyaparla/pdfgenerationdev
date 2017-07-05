module FSIProjectCompletionReport
  class ProjectCompletionDetailPage

  	def initialize(project)
      @project = project
    end
    
    def write(pdf)
      draw_pc_total_firestops_surveyed(pdf)
      draw_pc_total_firestops_fixedonsite(pdf)
    end

  private
  
    def draw_pc_total_firestops_surveyed(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        pdf.font_size 12
        pdf.text_box("Total # of Firestop Surveyed:", :at => [10, 365], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_fsi_surveyed}", :at => [315, 365])
      elsif array.length == 3
        pdf.font_size 12
        pdf.text_box("Total # of Firestop Surveyed:", :at => [10, 378], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_fsi_surveyed}", :at => [315, 378])
      else
        pdf.font_size 12
        pdf.text_box("Total # of Firestop Surveyed:", :at => [10, 390], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_fsi_surveyed}", :at => [315, 390])
      end
    end

    def draw_pc_total_firestops_fixedonsite(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        pdf.font_size 12
        pdf.text_box("Total # of Firestop Fixed on Site:", :at => [10, 350], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_fsi_fixedonsite}", :at => [315, 350])
      elsif array.length == 3
        pdf.font_size 12
        pdf.text_box("Total # of Firestop Fixed on Site:", :at => [10, 363], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_fsi_fixedonsite}", :at => [315, 363])
      else
        pdf.font_size 12
        pdf.text_box("Total # of Firestop Fixed on Site:", :at => [10, 375], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_fsi_fixedonsite}", :at => [315, 375])
      end 	
    end
  end
end