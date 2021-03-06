module DIProjectCompletionReport
  class ProjectCompletionDetailPage
  	#include Report::NewPageWritable

    def initialize(project)
      @project = project
    end

    def write(pdf)
      #super
      draw_pc_total_damper_inspected(pdf)
      draw_pc_total_damper_passed(pdf)
      draw_pc_total_damaper_failed(pdf)
      draw_pc_total_damper_na(pdf)
      draw_pc_total_access_doors_installed(pdf)
      # draw_base_bid_count(pdf)
      # draw_new_total_authorized_damper_bid(pdf)
      # array = @project.m_building.split(",")
      # if array.length >= 5
      # else
      # end
      # draw_pc_total_damper_inspected(pdf)
      # draw_pc_total_damper_passed(pdf)
      # draw_pc_total_damper_na(pdf)
      # draw_pc_total_access_doors_installed(pdf)
      # draw_base_bid_count(pdf)
      # draw_new_total_authorized_damper_bid(pdf)
    end

  private

    def draw_pc_total_damper_inspected(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        pdf.font_size 12
        #pdf.text_box("Total # of Dampers Inspected :", :at => [10, 118], :style => :bold)
        #pdf.text_box("Total # of Dampers Inspected :", :at => [10, 195], :style => :bold)
        #pdf.text_box("Total # of Dampers Inspected :", :at => [10, 200], :style => :bold) #197 old
        #pdf.text_box("Total # of Dampers Inspected :", :at => [10, 367], :style => :bold) new
        pdf.text_box("Total # of Dampers Inspected:", :at => [10, 365], :style => :bold)
        pdf.font_size 10
        #pdf.text_box("#{@project.m_total_no_of_dampers_inspected}", :at => [290, 118])
        #pdf.text_box("#{@project.m_total_no_of_dampers_inspected}", :at => [315, 195])
        #pdf.text_box("#{@project.m_total_no_of_dampers_inspected}", :at => [315, 200]) old
        #pdf.text_box("#{@project.m_total_no_of_dampers_inspected}", :at => [315, 367]) new
        pdf.text_box("#{@project.m_total_no_of_dampers_inspected}", :at => [315, 365])
      elsif array.length == 3
        pdf.font_size 12
        pdf.text_box("Total # of Dampers Inspected:", :at => [10, 378], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_dampers_inspected}", :at => [315, 378])
      else
        pdf.font_size 12
        pdf.text_box("Total # of Dampers Inspected:", :at => [10, 390], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_dampers_inspected}", :at => [315, 390])
      end
    end

    def draw_pc_total_damper_passed(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        pdf.font_size 12
        #pdf.text_box("Total # of Dampers Passed :", :at => [10, 103], :style => :bold)
        #pdf.text_box("Total # of Dampers Passed :", :at => [10, 180], :style => :bold)
        #pdf.text_box("Total # of Dampers Passed :", :at => [10, 185], :style => :bold) #182
        pdf.text_box("Total # of Dampers Passed:", :at => [10, 350], :style => :bold)
        pdf.font_size 10
        #pdf.text_box("#{@project.m_total_no_of_dampers_passed}", :at => [290, 103])
        #pdf.text_box("#{@project.m_total_no_of_dampers_passed}", :at => [315, 180])
        #pdf.text_box("#{@project.m_total_no_of_dampers_passed}", :at => [315, 185])
        pdf.text_box("#{@project.m_total_no_of_dampers_passed}", :at => [315, 350])
      elsif array.length == 3
        pdf.font_size 12
        pdf.text_box("Total # of Dampers Passed:", :at => [10, 363], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_dampers_passed}", :at => [315, 363])
      else
        pdf.font_size 12
        pdf.text_box("Total # of Dampers Passed:", :at => [10, 375], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_dampers_passed}", :at => [315, 375])
      end
    end

    def draw_pc_total_damaper_failed(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        pdf.font_size 12
        pdf.text_box("Total # of Dampers Failed:", :at => [10, 335], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_dampers_failed}", :at => [315, 335])
      elsif array.length == 3
        pdf.font_size 12
        pdf.text_box("Total # of Dampers Failed:", :at => [10, 348], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_dampers_failed}", :at => [315, 348])
      else
        pdf.font_size 12
        pdf.text_box("Total # of Dampers Failed:", :at => [10, 360], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_total_no_of_dampers_failed}", :at => [315, 360])
      end
    end

    def draw_pc_total_damper_na(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        pdf.font_size 12
        #pdf.text_box("Total # of Dampers N/A :", :at => [10, 88], :style => :bold)
        #pdf.text_box("Total # of Dampers N/A :", :at => [10, 165], :style => :bold)
        #pdf.text_box("Total # of Dampers N/A :", :at => [10, 170], :style => :bold) #167 old
        #pdf.text_box("Total # of Dampers N/A :", :at => [10, 337], :style => :bold) new
        #pdf.text_box("Total # of Dampers N/A:", :at => [10, 335], :style => :bold)
        pdf.text_box("Total # of Dampers N/A:", :at => [10, 320], :style => :bold)
        pdf.font_size 10
        #pdf.text_box("#{@project.m_total_no_of_dampers_na}", :at => [290, 88])
        #pdf.text_box("#{@project.m_total_no_of_dampers_na}", :at => [315, 88])
        #pdf.text_box("#{@project.m_total_no_of_dampers_na}", :at => [315, 165]) old
        #pdf.text_box("#{@project.m_total_no_of_dampers_na}", :at => [315, 337]) new
        #pdf.text_box("#{@project.m_total_no_of_dampers_na}", :at => [315, 335])
        pdf.text_box("#{@project.m_total_no_of_dampers_na}", :at => [315, 320])
      elsif array.length == 3
        pdf.font_size 12
        #pdf.text_box("Total # of Dampers N/A:", :at => [10, 348], :style => :bold)
        pdf.text_box("Total # of Dampers N/A:", :at => [10, 333], :style => :bold)
        pdf.font_size 10
        #pdf.text_box("#{@project.m_total_no_of_dampers_na}", :at => [315, 348])
        pdf.text_box("#{@project.m_total_no_of_dampers_na}", :at => [315, 333])
      else
        pdf.font_size 12
        #pdf.text_box("Total # of Dampers N/A:", :at => [10, 360], :style => :bold)
        pdf.text_box("Total # of Dampers N/A:", :at => [10, 345], :style => :bold)
        pdf.font_size 10
        #pdf.text_box("#{@project.m_total_no_of_dampers_na}", :at => [315, 360])
        pdf.text_box("#{@project.m_total_no_of_dampers_na}", :at => [315, 345])
      end
    end

    def draw_pc_total_access_doors_installed(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        pdf.font_size 12
        #pdf.text_box("Total # of Access Doors Installed :", :at => [10, 73], :style => :bold)
        #pdf.text_box("Total # of Access Doors Installed :", :at => [10, 150], :style => :bold)
        #pdf.text_box("Total # of Access Doors Installed :", :at => [10, 155], :style => :bold) #152 old
        #pdf.text_box("Total # of Access Doors Installed :", :at => [10, 322], :style => :bold) new
        #pdf.text_box("Total # of Access Doors Installed:", :at => [10, 320], :style => :bold)
        pdf.text_box("Total # of Access Doors Installed:", :at => [10, 305], :style => :bold)
        pdf.font_size 10
        #pdf.text_box("#{@project.m_total_no_of_damper_access_door_installed}", :at => [290, 73])
        #pdf.text_box("#{@project.m_total_no_of_damper_access_door_installed}", :at => [315, 73])
        #pdf.text_box("#{@project.m_total_no_of_damper_access_door_installed}", :at => [315, 150])
        #pdf.text_box("#{@project.m_total_no_of_damper_access_door_installed}", :at => [315, 155]) old
        #pdf.text_box("#{@project.m_total_no_of_damper_access_door_installed}", :at => [315, 322]) new
        #pdf.text_box("#{@project.m_total_no_of_damper_access_door_installed}", :at => [315, 320])
        pdf.text_box("#{@project.m_total_no_of_damper_access_door_installed}", :at => [315, 305])
      elsif array.length == 3
        pdf.font_size 12
        #pdf.text_box("Total # of Access Doors Installed:", :at => [10, 333], :style => :bold)
        pdf.text_box("Total # of Access Doors Installed:", :at => [10, 318], :style => :bold)
        pdf.font_size 10
        #pdf.text_box("#{@project.m_total_no_of_damper_access_door_installed}", :at => [315, 333])
        pdf.text_box("#{@project.m_total_no_of_damper_access_door_installed}", :at => [315, 318])
      else
        pdf.font_size 12
        #pdf.text_box("Total # of Access Doors Installed:", :at => [10, 345], :style => :bold)
        pdf.text_box("Total # of Access Doors Installed:", :at => [10, 330], :style => :bold)
        pdf.font_size 10
        #pdf.text_box("#{@project.m_total_no_of_damper_access_door_installed}", :at => [315, 345])
        pdf.text_box("#{@project.m_total_no_of_damper_access_door_installed}", :at => [315, 330])
      end
end

    # def draw_base_bid_count(pdf)
    #   array = @project.m_building.split(",")
    #   if array.length >= 5 
    #     pdf.font_size 12
    #     #pdf.text_box("Base Bid Count", :at => [10, 11], :style => :bold)
    #     #pdf.text_box("Base Bid Count", :at => [10, 60], :style => :bold) #47 old
    #     #pdf.text_box("Base Bid Count", :at => [10, 221], :style => :bold) new
    #     pdf.text_box("Base Bid Count", :at => [10, 219], :style => :bold)
    #     pdf.font_size 10
    #     #pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 11])
    #     #pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 60]) old
    #     #pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 221]) new
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
    #     #pdf.text_box("New Total Authorized Damper Bid", :at => [10, 45], :style => :bold) #32 old
    #     #pdf.text_box("New Total Authorized Damper Bid", :at => [10, 206], :style => :bold) new
    #     pdf.text_box("New Total Authorized Damper Inspected Bid", :at => [10, 204], :style => :bold)
    #     pdf.font_size 10
    #     #pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 45]) old
    #     #pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 206]) new
    #     pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 204])
    #   elsif array.length == 3
    #     pdf.font_size 12
    #     pdf.text_box("New Total Authorized Damper Inspected Bid", :at => [10, 217], :style => :bold)
    #     pdf.font_size 10
    #     pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 217])
    #   else
    #     pdf.font_size 12
    #     pdf.text_box("New Total Authorized Damper Inspected Bid", :at => [10, 229], :style => :bold)
    #     pdf.font_size 10
    #     pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 229])
    #   end
    # end

    # def projectcompletion_template
    #   'three_hundred_dpi/projectcomplettion_template.jpg'
    # end
  end
end