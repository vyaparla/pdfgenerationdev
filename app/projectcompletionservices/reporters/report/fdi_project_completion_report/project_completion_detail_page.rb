module FDIProjectCompletionReport
  class ProjectCompletionDetailPage
  	
  	def initialize(project)
      @project = project
    end

    def write(pdf)
      draw_pc_total_firedoor_inspected(pdf)
      draw_pc_total_firedoor_conformed(pdf)
      draw_pc_total_firedoor_nonconformed(pdf)      
      # draw_base_bid_count(pdf)
      # draw_new_total_authorized_damper_bid(pdf)
    end
  
  private

    def draw_pc_total_firedoor_inspected(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        pdf.font_size 12      
        pdf.text_box("Total # of Firedoors Inspected:", :at => [10, 347], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_firedoor_inspected}", :at => [315, 347])
      elsif array.length == 3
        pdf.font_size 12
        pdf.text_box("Total # of Firedoors Inspected:", :at => [10, 360], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_firedoor_inspected}", :at => [315, 360])
      else
        pdf.font_size 12
        pdf.text_box("Total # of Firedoors Inspected:", :at => [10, 372], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_firedoor_inspected}", :at => [315, 372])
      end
    end

    def draw_pc_total_firedoor_conformed(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        pdf.font_size 12        
        pdf.text_box("Total # of Firedoors Conformed:", :at => [10, 332], :style => :bold)
        pdf.font_size 10        
        pdf.text_box("#{@project.m_total_no_of_firedoor_conformed}", :at => [315, 332])
      elsif array.length == 3
        pdf.font_size 12
        pdf.text_box("Total # of Firedoors Conformed:", :at => [10, 345], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_firedoor_conformed}", :at => [315, 345])
      else
        pdf.font_size 12
        pdf.text_box("Total # of Firedoors Conformed:", :at => [10, 357], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_firedoor_conformed}", :at => [315, 357])
      end
    end

    def draw_pc_total_firedoor_nonconformed(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        pdf.font_size 12
        pdf.text_box("Total # of Firedoors Nonconformed:", :at => [10, 317], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_firedoor_nonconformed}", :at => [315, 317])
      elsif array.length == 3
        pdf.font_size 12
        pdf.text_box("Total # of Firedoors Nonconformed:", :at => [10, 330], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_firedoor_nonconformed}", :at => [315, 330])
      else
        pdf.font_size 12
        pdf.text_box("Total # of Firedoors Nonconformed:", :at => [10, 342], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_firedoor_nonconformed}", :at => [315, 342])
      end
    end
    
    # def draw_base_bid_count(pdf)
    #   array = @project.m_building.split(",")
    #   if array.length >= 5
    #     pdf.font_size 12        
    #     pdf.text_box("Base Bid Count", :at => [10, 219], :style => :bold)
    #     pdf.font_size 10
    #     pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 219])
    #   elsif array.length == 3
    #     pdf.font_size 12
    #     pdf.text_box("Base Bid Count", :at => [10, 232], :style => :bold)
    #     pdf.font_size 10
    #     pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 232])
    #   else
    #     pdf.font_size 12
    #     pdf.text_box("Base Bid Count", :at => [10, 244], :style => :bold)
    #     pdf.font_size 10
    #     pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 244])
    #   end
    # end

    # def draw_new_total_authorized_damper_bid(pdf)
    #   array = @project.m_building.split(",")
    #   if array.length >= 5
    #     pdf.font_size 12
    #     pdf.text_box("New Total Authorized Firedoor Bid", :at => [10, 204], :style => :bold)
    #     pdf.font_size 10
    #     pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 204])
    #   elsif array.length == 3
    #     pdf.font_size 12
    #     pdf.text_box("New Total Authorized Firedoor Bid", :at => [10, 217], :style => :bold)
    #     pdf.font_size 10
    #     pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 217])
    #   else
    #     pdf.font_size 12
    #     pdf.text_box("New Total Authorized Firedoor Bid", :at => [10, 229], :style => :bold)
    #     pdf.font_size 10
    #     pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 229])
    #   end
    # end
  end
end