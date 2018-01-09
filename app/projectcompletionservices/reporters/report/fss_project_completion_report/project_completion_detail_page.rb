module FSSProjectCompletionReport
  class ProjectCompletionDetailPage

  	def initialize(project)
      @project = project
    end
    
    def write(pdf)
      draw_pc_total_firestop_assets(pdf)
      draw_pc_total_firestops_surveyed(pdf)
      draw_pc_total_firestops_fixedonsite(pdf)
    end

  private

    def draw_pc_total_firestop_assets(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        pdf.font_size 12
        pdf.text_box("Total # of Firestop Assets:", :at => [10, 347], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_firestop_assets}", :at => [315, 347])
      elsif array.length == 3
        pdf.font_size 12
        pdf.text_box("Total # of Firestop Assets:", :at => [10, 360], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_firestop_assets}", :at => [315, 360])
      else
        pdf.font_size 12
        pdf.text_box("Total # of Firestop Assets:", :at => [10, 372], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_firestop_assets}", :at => [315, 372])
      end
    end 

  
    def draw_pc_total_firestops_surveyed(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        pdf.font_size 12
        pdf.text_box("Total # of Firestops Surveyed:", :at => [10, 332], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_firestop_surveyed}", :at => [315, 332])
      elsif array.length == 3
        pdf.font_size 12
        pdf.text_box("Total # of Firestops Surveyed:", :at => [10, 345], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_firestop_surveyed}", :at => [315, 345])
      else
        pdf.font_size 12
        pdf.text_box("Total # of Firestops Surveyed:", :at => [10, 357], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_firestop_surveyed}", :at => [315, 357])
      end
    end

    def draw_pc_total_firestops_fixedonsite(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        pdf.font_size 12
        pdf.text_box("Total # of Firestops Fixed on Site:", :at => [10, 317], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_firestop_fixedonsite}", :at => [315, 317])
      elsif array.length == 3
        pdf.font_size 12
        pdf.text_box("Total # of Firestops Fixed on Site:", :at => [10, 330], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_firestop_fixedonsite}", :at => [315, 330])
      else
        pdf.font_size 12
        pdf.text_box("Total # of Firestops Fixed on Site:", :at => [10, 342], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_firestop_fixedonsite}", :at => [315, 342])
      end 	
    end
  end
end