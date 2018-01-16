module Report
  class CommonDetailPage
  	include NewPageWritable

    def initialize(project)
      @project = project
    end

    def write(pdf)
      super
      #draw_project_completion_data(pdf)
      draw_facility_name(pdf)
      draw_building_name(pdf)
      draw_servicve_type(pdf)
      draw_service_start_date(pdf)
      draw_service_end_date(pdf)
      draw_primary_contact_name(pdf)
      draw_phone_number(pdf)      
      draw_customer_hard_copy_text(pdf)
      draw_printed_report(pdf)
      draw_customer_requests_text(pdf)
      draw_autocad(pdf)
      draw_containment_tent_used(pdf)
      draw_inspection_over_base_bid(pdf)
      draw_base_bid_count(pdf)
      draw_new_total_authorized_damper_bid(pdf)
      draw_date(pdf)
      draw_tech_name(pdf)
      draw_customer_name(pdf)
      draw_signature(pdf)
    end

  private

    def project
      @project
    end

    # def draw_project_completion_data(pdf)
    #   pdf.move_down 110
    #   pdf.font_size 15
    #   pdf.text_box("Project Completion", :at => [0, 462], :style => :bold)
    #   pdf.text_box("Date : #{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [420, 462])
    #   pdf.stroke_horizontal_rule
    # end

    def draw_facility_name(pdf)
      #pdf.move_down 130
      pdf.font_size 12
      #pdf.text_box("Facility", :at => [10, 425], :style => :bold)
      #pdf.text_box("Facility", :at => [10, 445], :style => :bold) old
      #pdf.text_box("Facility", :at => [10, 612], :style => :bold) new
      pdf.text_box("Facility", :at => [10, 635], :style => :bold)
      pdf.font_size 10
      #pdf.text_box("#{@project.m_facility}", :at => [290, 425])
      #pdf.text_box("#{@project.m_facility}", :at => [290, 445]) old
      #pdf.text_box("#{@project.m_facility}", :at => [290, 612]) new
      pdf.text_box("#{@project.m_facility}", :at => [290, 635])
    end

    def draw_building_name(pdf)
      #pdf.move_down 140
      pdf.font_size 12
      #pdf.text_box("Building", :at => [10, 403], :style => :bold)
      #pdf.text_box("Building", :at => [10, 427], :style => :bold) old
      #pdf.text_box("Building", :at => [10, 594], :style => :bold) new
      pdf.text_box("Building", :at => [10, 617], :style => :bold)
      pdf.font_size 10
      #pdf.text_box("#{@project.m_building}", :at => [290, 403])
      #pdf.text_box("#{@project.m_building}", :at => [290, 427]) old
      #pdf.text_box("#{@project.m_building}", :at => [290, 594]) new
      pdf.text_box("#{@project.m_building}", :at => [290, 617])
    end

    def draw_servicve_type(pdf)
      #pdf.move_down 150
      array = @project.m_building.split(",")
      if array.length >= 5
        pdf.font_size 12 #43
        #pdf.text_box("LSS Service / Service Type Performed", :at => [10, 380], :style => :bold)
        #pdf.text_box("LSS Service / Service Type Performed", :at => [10, 409], :style => :bold) old
        #pdf.text_box("LSS Service / Service Type Performed", :at => [10, 576], :style => :bold) new
        pdf.text_box("LSS Service / Service Type Performed", :at => [10, 574], :style => :bold)
        pdf.font_size 10
        #pdf.text_box("#{@project.m_servicetype}", :at => [290, 380])
        #pdf.text_box("#{@project.m_servicetype}", :at => [290, 409]) old
        #pdf.text_box("#{@project.m_servicetype}", :at => [290, 576]) new
        pdf.text_box("#{@project.m_servicetype}", :at => [290, 574])
      elsif array.length == 3 #30
        pdf.font_size 12
        pdf.text_box("LSS Service / Service Type Performed", :at => [10, 587], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_servicetype}", :at => [290, 587])
      else #18
        pdf.font_size 12
        pdf.text_box("LSS Service / Service Type Performed", :at => [10, 599], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_servicetype}", :at => [290, 599])
      end  
    end

    def draw_service_start_date(pdf)
      #pdf.move_down 150
      array = @project.m_building.split(",")
      if array.length >= 5 #18
        pdf.font_size 12
        #pdf.text_box("Service Start Date", :at => [10, 355], :style => :bold)
        #pdf.text_box("Service Start Date", :at => [10, 391], :style => :bold) old
        #pdf.text_box("Service Start Date", :at => [10, 558], :style => :bold) new
        pdf.text_box("Service Start Date", :at => [10, 556], :style => :bold)
        pdf.font_size 10
        #pdf.text_box("#{@project.m_project_start_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [290, 355])
        #pdf.text_box("#{@project.m_project_start_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [290, 391]) old 
        #pdf.text_box("#{@project.m_project_start_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [290, 558]) new
        pdf.text_box("#{@project.m_project_start_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [290, 556])
      elsif array.length == 3
        pdf.font_size 12
        pdf.text_box("Service Start Date", :at => [10, 569], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_project_start_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [290, 569])
      else
        pdf.font_size 12
        pdf.text_box("Service Start Date", :at => [10, 581], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_project_start_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [290, 581])
      end
    end

    def draw_service_end_date(pdf)
      #pdf.move_down 160
      array = @project.m_building.split(",")
      if array.length >= 5
        pdf.font_size 12
        #pdf.text_box("Service End Date", :at => [10, 328], :style => :bold)
        #pdf.text_box("Service End Date", :at => [10, 373], :style => :bold) old
        #pdf.text_box("Service End Date", :at => [10, 540], :style => :bold) new
        pdf.text_box("Service End Date", :at => [10, 538], :style => :bold)
        pdf.font_size 10
        #pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [290, 328])
        #pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [290, 373]) old
        #pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [290, 540]) new
        pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [290, 538])
      elsif array.length == 3
        pdf.font_size 12
        pdf.text_box("Service End Date", :at => [10, 551], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [290, 551])
      else
        pdf.font_size 12
        pdf.text_box("Service End Date", :at => [10, 563], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [290, 563])
      end
    end
   
    def draw_primary_contact_name(pdf)
      #pdf.move_down 160
      array = @project.m_building.split(",")
      if array.length >= 5
        pdf.font_size 12
        #pdf.text_box("Primary Contact", :at => [10, 303], :style => :bold)
        #pdf.text_box("Primary Contact", :at => [10, 355], :style => :bold) ol
        #pdf.text_box("Primary Contact", :at => [10, 522], :style => :bold) new
        pdf.text_box("Primary Contact", :at => [10, 520], :style => :bold)
        pdf.font_size 10
        #pdf.text_box("#{@project.m_primary_contact_name}", :at => [290, 303])
        #pdf.text_box("#{@project.m_primary_contact_name}", :at => [290, 355]) old
        #pdf.text_box("#{@project.m_primary_contact_name}", :at => [290, 522]) new
        pdf.text_box("#{@project.m_primary_contact_name}", :at => [290, 520])
      elsif array.length == 3
        pdf.font_size 12
        pdf.text_box("Primary Contact", :at => [10, 533], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_primary_contact_name}", :at => [290, 533])
      else
        pdf.font_size 12
        pdf.text_box("Primary Contact", :at => [10, 545], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_primary_contact_name}", :at => [290, 545])
      end
    end

    def draw_phone_number(pdf)
      #pdf.move_down 160
      array = @project.m_building.split(",")
      if array.length >= 5
        pdf.font_size 12
        #pdf.text_box("Phone #", :at => [10, 278], :style => :bold)
        #pdf.text_box("Phone #", :at => [10, 337], :style => :bold) old
        #pdf.text_box("Phone #", :at => [10, 504], :style => :bold) new
        pdf.text_box("Phone #", :at => [10, 502], :style => :bold)
        pdf.font_size 10
        #pdf.text_box("#{@project.m_phone}", :at => [290, 278])
        #pdf.text_box("#{@project.m_phone}", :at => [290, 337]) old
        #pdf.text_box("#{@project.m_phone}", :at => [290, 504]) new
        pdf.text_box("#{@project.m_phone}", :at => [290, 502])
      elsif array.length == 3
        pdf.font_size 12
        pdf.text_box("Phone #", :at => [10, 515], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_phone}", :at => [290, 515])
      else
        pdf.font_size 12
        pdf.text_box("Phone #", :at => [10, 527], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_phone}", :at => [290, 527])
      end      
    end

    def draw_customer_hard_copy_text(pdf)
      #pdf.move_down 170
      array = @project.m_building.split(",")
      pdf.font_size 12
      if array.length >= 5
        pdf.text_box("Customer wants hard copy of inspection report mailed to them at an additional charge. For details, customer will need to contact their sales representative. (if not, a link will be emailed to access LSS Site Surveyor® for you to download the report)", 
                    :at => [10, 484], :align => :justify, :style => :bold) #:at => [10, 253] :at => [10, 319] old, :at => [10, 486] new
      elsif array.length == 3
        pdf.text_box("Customer wants hard copy of inspection report mailed to them at an additional charge. For details, customer will need to contact their sales representative. (if not, a link will be emailed to access LSS Site Surveyor® for you to download the report)", 
                    :at => [10, 497], :align => :justify, :style => :bold)
      else
        pdf.text_box("Customer wants hard copy of inspection report mailed to them at an additional charge. For details, customer will need to contact their sales representative. (if not, a link will be emailed to access LSS Site Surveyor® for you to download the report)", 
                    :at => [10, 509], :align => :justify, :style => :bold)
      end
    end

    def draw_printed_report(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        pdf.font_size 12
        #pdf.text_box("Printed Report", :at => [10, 271], :style => :bold) old
        #pdf.text_box("Printed Report", :at => [10, 438], :style => :bold) new
        pdf.text_box("Printed Report", :at => [10, 436], :style => :bold)
        pdf.font_size 10
        if @project.m_printed_report == "Yes"
          #pdf.text_box("Y", :at => [290, 203])
          #pdf.text_box("Y", :at => [315, 203])
          #pdf.text_box("Y", :at => [315, 271]) old
          #pdf.text_box("Y", :at => [315, 438]) new
          pdf.text_box("Y", :at => [315, 436])
        else 
          #pdf.text_box("N", :at => [290, 203])
          #pdf.text_box("N", :at => [315, 203])
          #pdf.text_box("N", :at => [315, 271]) old
          #pdf.text_box("N", :at => [315, 438]) new
          pdf.text_box("N", :at => [315, 436])
        end
      elsif array.length == 3
        pdf.font_size 12
        pdf.text_box("Printed Report", :at => [10, 449], :style => :bold)
        pdf.font_size 10
        if @project.m_printed_report == "Yes"
          pdf.text_box("Y", :at => [315, 449])
        else
          pdf.text_box("N", :at => [315, 449])
        end
      else
        pdf.font_size 12
        pdf.text_box("Printed Report", :at => [10, 461], :style => :bold)
        pdf.font_size 10
        if @project.m_printed_report == "Yes"
          pdf.text_box("Y", :at => [315, 461])
        else
          pdf.text_box("N", :at => [315, 461])
        end
      end
    end

    def draw_customer_requests_text(pdf)
      pdf.font_size 12
      array = @project.m_building.split(",")
      if array.length >= 5
        pdf.text_box("Customer requests the hand mapped drawings be converted to AutoCAD and agrees to an additional charge. For details, customer will need to contact their sales representative.",
                   :at => [10, 418], :align => :justify, :style => :bold) #:at => [10, 180] , :at => [10, 253] old, :at => [10, 420] new  
      elsif array.length == 3
        pdf.text_box("Customer requests the hand mapped drawings be converted to AutoCAD and agrees to an additional charge. For details, customer will need to contact their sales representative.",
                   :at => [10, 431], :align => :justify, :style => :bold)
      else
        pdf.text_box("Customer requests the hand mapped drawings be converted to AutoCAD and agrees to an additional charge. For details, customer will need to contact their sales representative.",
                   :at => [10, 443], :align => :justify, :style => :bold)
      end
    end

    def draw_autocad(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        pdf.font_size 12
        #pdf.text_box("AutoCAD", :at => [10, 143], :style => :bold) old
        #pdf.text_box("AutoCAD", :at => [10, 387], :style => :bold) new
        pdf.text_box("AutoCAD", :at => [10, 385], :style => :bold)
        pdf.font_size 10
        if @project.m_autocad == "Yes"
          #pdf.text_box("Y", :at => [290, 143]) old
          #pdf.text_box("Y", :at => [315, 387]) new
          pdf.text_box("Y", :at => [315, 385])
        else 
          #pdf.text_box("N", :at => [290, 143]) old
          #pdf.text_box("N", :at => [315, 387]) new
          pdf.text_box("N", :at => [315, 385])
        end
      elsif array.length == 3
        pdf.font_size 12
        pdf.text_box("AutoCAD", :at => [10, 398], :style => :bold)
        pdf.font_size 10
        if @project.m_autocad == "Yes"
          pdf.text_box("Y", :at => [315, 398])
        else
          pdf.text_box("N", :at => [315, 398])
        end
      else
        pdf.font_size 12
        pdf.text_box("AutoCAD", :at => [10, 410], :style => :bold)
        pdf.font_size 10
        if @project.m_autocad == "Yes"
          pdf.text_box("Y", :at => [315, 410])
        else
          pdf.text_box("N", :at => [315, 410])
        end
      end
    end

    def draw_containment_tent_used(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Containment Tent Used?", :at => [10, 320], :style => :bold)
          pdf.font_size 10
          if @project.m_containment_tent_used == "Yes"
            pdf.text_box("Y", :at => [315, 320])
          elsif @project.m_containment_tent_used == "No"
            pdf.text_box("N", :at => [315, 320])
          else
            pdf.text_box("NA", :at => [315, 320])
          end
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.font_size 12
          pdf.text_box("Containment Tent Used?", :at => [10, 320], :style => :bold)
          pdf.font_size 10
          if @project.m_containment_tent_used == "Yes"
            pdf.text_box("Y", :at => [315, 320])
          elsif @project.m_containment_tent_used == "No"
            pdf.text_box("N", :at => [315, 320])
          else
            pdf.text_box("NA", :at => [315, 320])
          end
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.font_size 12
          pdf.text_box("Containment Tent Used?", :at => [10, 320], :style => :bold)
          pdf.font_size 10
          if @project.m_containment_tent_used == "Yes"
            pdf.text_box("Y", :at => [315, 320])
          elsif @project.m_containment_tent_used == "No"
            pdf.text_box("N", :at => [315, 320])
          else
            pdf.text_box("NA", :at => [315, 320])
          end
        else
          pdf.font_size 12
          #pdf.text_box("Containment Tent Used?", :at => [10, 58], :style => :bold) #53
          #pdf.text_box("Containment Tent Used?", :at => [10, 140], :style => :bold) #53, 135 old
          #pdf.text_box("Containment Tent Used?", :at => [10, 307], :style => :bold) new
          #pdf.text_box("Containment Tent Used?", :at => [10, 305], :style => :bold)
          pdf.text_box("Containment Tent Used?", :at => [10, 290], :style => :bold)
          pdf.font_size 10
          if @project.m_containment_tent_used == "Yes"
            #pdf.text_box("Y", :at => [290, 58])
            #pdf.text_box("Y", :at => [315, 58])
            #pdf.text_box("Y", :at => [315, 140]) old
            #pdf.text_box("Y", :at => [315, 307]) new
            #pdf.text_box("Y", :at => [315, 305])
            pdf.text_box("Y", :at => [315, 290])
          elsif @project.m_containment_tent_used == "No"
            #pdf.text_box("N", :at => [290, 58])
            #pdf.text_box("N", :at => [315, 58])
            #pdf.text_box("N", :at => [315, 140]) old
            #pdf.text_box("N", :at => [315, 307]) new
            #pdf.text_box("N", :at => [315, 305])
            pdf.text_box("N", :at => [315, 290])
          else
            #pdf.text_box("NA", :at => [315, 305])
            pdf.text_box("NA", :at => [315, 290])
          end
        end      
      elsif array.length == 3
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Containment Tent Used?", :at => [10, 333], :style => :bold)
          pdf.font_size 10
          if @project.m_containment_tent_used == "Yes"
            pdf.text_box("Y", :at => [315, 333])
          elsif @project.m_containment_tent_used == "No"
            pdf.text_box("N", :at => [315, 333])
          else
            pdf.text_box("NA", :at => [315, 333])
          end
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.font_size 12
          pdf.text_box("Containment Tent Used?", :at => [10, 333], :style => :bold)
          pdf.font_size 10
          if @project.m_containment_tent_used == "Yes"
            pdf.text_box("Y", :at => [315, 333])
          elsif @project.m_containment_tent_used == "No"
            pdf.text_box("N", :at => [315, 333])
          else
            pdf.text_box("NA", :at => [315, 333])
          end
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.font_size 12
          pdf.text_box("Containment Tent Used?", :at => [10, 333], :style => :bold)
          pdf.font_size 10
          if @project.m_containment_tent_used == "Yes"
            pdf.text_box("Y", :at => [315, 333])
          elsif @project.m_containment_tent_used == "No"
            pdf.text_box("N", :at => [315, 333])
          else
            pdf.text_box("NA", :at => [315, 333])
          end
        else
          pdf.font_size 12
          #pdf.text_box("Containment Tent Used?", :at => [10, 318], :style => :bold)
          pdf.text_box("Containment Tent Used?", :at => [10, 303], :style => :bold)
          pdf.font_size 10
          if @project.m_containment_tent_used == "Yes"
            #pdf.text_box("Y", :at => [315, 318])
            pdf.text_box("Y", :at => [315, 303])
          elsif @project.m_containment_tent_used == "No"
            #pdf.text_box("N", :at => [315, 318])
            pdf.text_box("N", :at => [315, 303])
          else
            pdf.text_box("NA", :at => [315, 303])
          end
        end
      else
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Containment Tent Used?", :at => [10, 345], :style => :bold)
          pdf.font_size 10
          if @project.m_containment_tent_used == "Yes"
            pdf.text_box("Y", :at => [315, 345])
          elsif @project.m_containment_tent_used == "No"
            pdf.text_box("N", :at => [315, 345])
          else
            pdf.text_box("NA", :at => [315, 345])
          end
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.font_size 12
          pdf.text_box("Containment Tent Used?", :at => [10, 345], :style => :bold)
          pdf.font_size 10
          if @project.m_containment_tent_used == "Yes"
            pdf.text_box("Y", :at => [315, 345])
          elsif @project.m_containment_tent_used == "No"
            pdf.text_box("N", :at => [315, 345])
          else
            pdf.text_box("NA", :at => [315, 345])
          end
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.font_size 12
          pdf.text_box("Containment Tent Used?", :at => [10, 345], :style => :bold)
          pdf.font_size 10
          if @project.m_containment_tent_used == "Yes"
            pdf.text_box("Y", :at => [315, 345])
          elsif @project.m_containment_tent_used == "No"
            pdf.text_box("N", :at => [315, 345])
          else
            pdf.text_box("NA", :at => [315, 345])
          end
        else
          pdf.font_size 12
          #pdf.text_box("Containment Tent Used?", :at => [10, 330], :style => :bold)
          pdf.text_box("Containment Tent Used?", :at => [10, 315], :style => :bold)
          pdf.font_size 10
          if @project.m_containment_tent_used == "Yes"
            #pdf.text_box("Y", :at => [315, 330])
            pdf.text_box("Y", :at => [315, 315])
          elsif @project.m_containment_tent_used == "No"
            #pdf.text_box("N", :at => [315, 330])
            pdf.text_box("N", :at => [315, 315])
          else
            #pdf.text_box("NA", :at => [315, 330])
            pdf.text_box("NA", :at => [315, 315])
          end
        end
      end
    end

    def draw_inspection_over_base_bid(pdf)
      pdf.font_size 12
      #pdf.text_box("INSPECTION OVER BASE BID: I acknowledge that the damper count stated on the proposal has been reached. I have the authority to authorize the continuation of the damper project to completion or to the new total damper count stated below. Your signature below will act as official approval - no further documents, purchase orders, or other forms shall be construed to modify this approval.", :at => [10, 110], :align => :justify, :style => :bold) #:at => [10, 33]
      array = @project.m_building.split(",")
      if array.length >= 5
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.text_box("INSPECTION OVER BASE BID:", :at => [10, 297], :style => :bold)
          pdf.text_box("I acknowledge that the damper count stated on the proposal has", :at => [192, 297], :align => :justify)
          pdf.text_box("been reached. I have the authority to authorize the continuation of the damper project to completion or to the new total damper count stated below. Your signature below will act as official approval - no further documents, purchase orders, or other forms shall be construed to modify this approval.",
                     :at => [10, 282], :align => :justify)
        elsif @project.m_servicetype == "Firestop Survey"
        elsif @project.m_servicetype == "Firestop Installation"
        else
          #pdf.text_box("INSPECTION OVER BASE BID:", :at => [10, 282], :style => :bold) #110 :at => [10, 120] old, :at => [10, 284] new
          pdf.text_box("INSPECTION OVER BASE BID:", :at => [10, 267], :style => :bold)
          #pdf.text_box("I acknowledge that the damper count stated on the proposal has", :at => [192, 282], :align => :justify)  #:at => [10, 110], :at => [192, 120] old,  :at => [192, 284] new
          pdf.text_box("I acknowledge that the damper count stated on the proposal has", :at => [192, 267], :align => :justify)
          #pdf.text_box("been reached. I have the authority to authorize the continuation of the damper project to completion or to the new total damper count stated below. Your signature below will act as official approval - no further documents, purchase orders, or other forms shall be construed to modify this approval.", :at => [10, 267], :align => :justify) #95 :at => [10, 105] old, :at => [10, 269] new
          pdf.text_box("been reached. I have the authority to authorize the continuation of the damper project to completion or to the new total damper count stated below. Your signature below will act as official approval - no further documents, purchase orders, or other forms shall be construed to modify this approval.", 
                       :at => [10, 252], :align => :justify)
        end
      elsif array.length == 3
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.text_box("INSPECTION OVER BASE BID:", :at => [10, 310], :style => :bold)
          pdf.text_box("I acknowledge that the damper count stated on the proposal has", :at => [192, 310], :align => :justify)
          pdf.text_box("been reached. I have the authority to authorize the continuation of the damper project to completion or to the new total damper count stated below. Your signature below will act as official approval - no further documents, purchase orders, or other forms shall be construed to modify this approval.",
                     :at => [10, 295], :align => :justify)
        elsif @project.m_servicetype == "Firestop Survey"
        elsif @project.m_servicetype == "Firestop Installation"  
        else
          #pdf.text_box("INSPECTION OVER BASE BID:", :at => [10, 295], :style => :bold)
          pdf.text_box("INSPECTION OVER BASE BID:", :at => [10, 280], :style => :bold)
          #pdf.text_box("I acknowledge that the damper count stated on the proposal has", :at => [192, 295], :align => :justify)
          pdf.text_box("I acknowledge that the damper count stated on the proposal has", :at => [192, 280], :align => :justify)
          #pdf.text_box("been reached. I have the authority to authorize the continuation of the damper project to completion or to the new total damper count stated below. Your signature below will act as official approval - no further documents, purchase orders, or other forms shall be construed to modify this approval.", :at => [10, 280], :align => :justify)
          pdf.text_box("been reached. I have the authority to authorize the continuation of the damper project to completion or to the new total damper count stated below. Your signature below will act as official approval - no further documents, purchase orders, or other forms shall be construed to modify this approval.", 
                       :at => [10, 265], :align => :justify)
        end        
      else
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.text_box("INSPECTION OVER BASE BID:", :at => [10, 322], :style => :bold)
          pdf.text_box("I acknowledge that the damper count stated on the proposal has", :at => [192, 322], :align => :justify)
          pdf.text_box("been reached. I have the authority to authorize the continuation of the damper project to completion or to the new total damper count stated below. Your signature below will act as official approval - no further documents, purchase orders, or other forms shall be construed to modify this approval.",
                     :at => [10, 307], :align => :justify)
        elsif @project.m_servicetype == "Firestop Survey"
        elsif @project.m_servicetype == "Firestop Installation"  
        else
          #pdf.text_box("INSPECTION OVER BASE BID:", :at => [10, 307], :style => :bold)
          pdf.text_box("INSPECTION OVER BASE BID:", :at => [10, 284], :style => :bold)
          #pdf.text_box("I acknowledge that the damper count stated on the proposal has", :at => [192, 307], :align => :justify)
          pdf.text_box("I acknowledge that the damper count stated on the proposal has", :at => [192, 284], :align => :justify)
          #pdf.text_box("been reached. I have the authority to authorize the continuation of the damper project to completion or to the new total damper count stated below. Your signature below will act as official approval - no further documents, purchase orders, or other forms shall be construed to modify this approval.", :at => [10, 292], :align => :justify)
          pdf.text_box("been reached. I have the authority to authorize the continuation of the damper project to completion or to the new total damper count stated below. Your signature below will act as official approval - no further documents, purchase orders, or other forms shall be construed to modify this approval.", 
                      :at => [10, 269], :align => :justify)
        end        
      end
    end

    # def draw_base_bid_count(pdf)
    #   pdf.font_size 12
    #   #pdf.text_box("Base Bid Count", :at => [10, 11], :style => :bold)
    #   pdf.text_box("Base Bid Count", :at => [10, 60], :style => :bold) #47
    #   pdf.font_size 10
    #   #pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 11])
    #   pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 60])
    # end

    # def draw_new_total_authorized_damper_bid(pdf)
    #   pdf.font_size 12
    #   pdf.text_box("New Total Authorized Damper Bid", :at => [10, 45], :style => :bold) #32
    #   pdf.font_size 10
    #   pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 45])
    # end

    def draw_base_bid_count(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Base Bid Count", :at => [10, 234], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 234])
        elsif @project.m_servicetype == "Firestop Survey"
        elsif @project.m_servicetype == "Firestop Installation"
        else
          pdf.font_size 12
          #pdf.text_box("Base Bid Count", :at => [10, 11], :style => :bold)
          #pdf.text_box("Base Bid Count", :at => [10, 60], :style => :bold) #47 old
          #pdf.text_box("Base Bid Count", :at => [10, 221], :style => :bold) new
          #pdf.text_box("Base Bid Count", :at => [10, 219], :style => :bold)
          #pdf.text_box("Base Bid Count", :at => [10, 189], :style => :bold)
          pdf.text_box("Base Bid Count", :at => [10, 199], :style => :bold)
          pdf.font_size 10
          #pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 11])
          #pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 60]) old
          #pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 221]) new
          #pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 219])
          #pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 189])
          pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 199])
        end        
      elsif array.length == 3
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Base Bid Count", :at => [10, 247], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 247])
        elsif @project.m_servicetype == "Firestop Survey"
        elsif @project.m_servicetype == "Firestop Installation"  
        else
          pdf.font_size 12
          #pdf.text_box("Base Bid Count", :at => [10, 232], :style => :bold)
          #pdf.text_box("Base Bid Count", :at => [10, 202], :style => :bold)
          pdf.text_box("Base Bid Count", :at => [10, 212], :style => :bold)
          pdf.font_size 10
          #pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 232])
          pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 212])
        end
      else
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Base Bid Count", :at => [10, 259], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 259])
        elsif @project.m_servicetype == "Firestop Survey"
        elsif @project.m_servicetype == "Firestop Installation"  
        else
          pdf.font_size 12
          #pdf.text_box("Base Bid Count", :at => [10, 244], :style => :bold)
          pdf.text_box("Base Bid Count", :at => [10, 216], :style => :bold)
          pdf.font_size 10
          #pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 244])
          pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 216])
        end
      end
    end

    def draw_new_total_authorized_damper_bid(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("New Total Authorized Firedoor Bid", :at => [10, 219], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 219])
        elsif @project.m_servicetype == "Firestop Survey"
        elsif @project.m_servicetype == "Firestop Installation"  
        else
          pdf.font_size 12
          #pdf.text_box("New Total Authorized Damper Bid", :at => [10, 45], :style => :bold) #32 old
          #pdf.text_box("New Total Authorized Damper Bid", :at => [10, 206], :style => :bold) new
          if @project.m_servicetype == "Damper Inspection"
            #pdf.text_box("New Total Authorized Damper Inspected Bid", :at => [10, 204], :style => :bold)
            #pdf.text_box("New Total Authorized Damper Inspected Bid", :at => [10, 174], :style => :bold)
            pdf.text_box("New Total Authorized Damper Inspected Bid", :at => [10, 184], :style => :bold)
          else
            #pdf.text_box("New Total Authorized Damper Repaired Bid", :at => [10, 204], :style => :bold)
            #pdf.text_box("New Total Authorized Damper Repaired Bid", :at => [10, 174], :style => :bold)
            pdf.text_box("New Total Authorized Damper Repaired Bid", :at => [10, 184], :style => :bold)
          end
          pdf.font_size 10
          #pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 45]) old
          #pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 206]) new
          #pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 204])
          #pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 174])
          pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 184])
        end         
      elsif array.length == 3
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("New Total Authorized Firedoor Bid", :at => [10, 232], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 232])
        elsif @project.m_servicetype == "Firestop Survey"
        elsif @project.m_servicetype == "Firestop Installation"  
        else
          pdf.font_size 12
          if @project.m_servicetype == "Damper Inspection"
            #pdf.text_box("New Total Authorized Damper Inspected Bid", :at => [10, 217], :style => :bold)
            #pdf.text_box("New Total Authorized Damper Inspected Bid", :at => [10, 187], :style => :bold)
            pdf.text_box("New Total Authorized Damper Inspected Bid", :at => [10, 197], :style => :bold)
          else
            #pdf.text_box("New Total Authorized Damper Repaired Bid", :at => [10, 217], :style => :bold)
            #pdf.text_box("New Total Authorized Damper Repaired Bid", :at => [10, 187], :style => :bold)
            pdf.text_box("New Total Authorized Damper Repaired Bid", :at => [10, 197], :style => :bold)
          end
          pdf.font_size 10
          #pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 217])
          #pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 187])
          pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 197])
        end        
      else
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("New Total Authorized Firedoor Bid", :at => [10, 244], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 244])
        elsif @project.m_servicetype == "Firestop Survey"
        elsif @project.m_servicetype == "Firestop Installation"  
        else
          pdf.font_size 12
          if @project.m_servicetype == "Damper Inspection"
            #pdf.text_box("New Total Authorized Damper Inspected Bid", :at => [10, 229], :style => :bold)
            #pdf.text_box("New Total Authorized Damper Inspected Bid", :at => [10, 191], :style => :bold)
            pdf.text_box("New Total Authorized Damper Inspected Bid", :at => [10, 201], :style => :bold)
          else
            #pdf.text_box("New Total Authorized Damper Repaired Bid", :at => [10, 229], :style => :bold)
            #pdf.text_box("New Total Authorized Damper Repaired Bid", :at => [10, 191], :style => :bold)
            pdf.text_box("New Total Authorized Damper Repaired Bid", :at => [10, 201], :style => :bold)
          end
          pdf.font_size 10
          #pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 229])
          #pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 191])
          pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 201])
        end        
      end
    end
    
    def draw_date(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Date", :at => [10, 201], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 201])
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.font_size 12
          pdf.text_box("Date", :at => [10, 300], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 300])
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.font_size 12
          pdf.text_box("Date", :at => [10, 300], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 300])
        else
          pdf.font_size 12
          #pdf.text_box("Date", :at => [10, 30], :style => :bold) #17 old
          #pdf.text_box("Date", :at => [10, 188], :style => :bold) new
          #pdf.text_box("Date", :at => [10, 186], :style => :bold)
          #pdf.text_box("Date", :at => [10, 156], :style => :bold)
          pdf.text_box("Date", :at => [10, 169], :style => :bold)
          pdf.font_size 10
          #pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 30]) old
          #pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 188]) new
          #pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 186])
          #pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 156])
          pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 169])
        end        
      elsif array.length == 3
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Date", :at => [10, 214], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 214])
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.font_size 12
          pdf.text_box("Date", :at => [10, 313], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 313])
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.font_size 12
          pdf.text_box("Date", :at => [10, 313], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 313])
        else
          pdf.font_size 12
          #pdf.text_box("Date", :at => [10, 199], :style => :bold)
          #pdf.text_box("Date", :at => [10, 169], :style => :bold)
          pdf.text_box("Date", :at => [10, 182], :style => :bold)
          pdf.font_size 10
          #pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 199])
          #pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 169])
          pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 182])
        end        
      else
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Date", :at => [10, 226], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 226])
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.font_size 12
          pdf.text_box("Date", :at => [10, 325], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 325])
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.font_size 12
          pdf.text_box("Date", :at => [10, 325], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 325])
        else
          pdf.font_size 12
          #pdf.text_box("Date", :at => [10, 211], :style => :bold)
          #pdf.text_box("Date", :at => [10, 173], :style => :bold)
          pdf.text_box("Date", :at => [10, 186], :style => :bold)
          pdf.font_size 10
          #pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 211])
          #pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 173])
          pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 186])
        end        
      end
    end

    def draw_tech_name(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Technician Name", :at => [10, 186], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_technician_name}", :at => [315, 186])
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.font_size 12
          pdf.text_box("Technician Name", :at => [10, 285], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_technician_name}", :at => [315, 285])
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.font_size 12
          pdf.text_box("Technician Name", :at => [10, 285], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_technician_name}", :at => [315, 285])
        else
          pdf.font_size 12
          #pdf.text_box("Name", :at => [10, 15], :style => :bold) #2 old
          #pdf.text_box("Name", :at => [10, 173], :style => :bold) new
          #pdf.text_box("Name", :at => [10, 171], :style => :bold)
          #pdf.text_box("Name", :at => [10, 141], :style => :bold)
          pdf.text_box("Technician Name", :at => [10, 154], :style => :bold)
          pdf.font_size 10
          #pdf.text_box("#{@project.m_technician_name}", :at => [315, 15]) old
          #pdf.text_box("#{@project.m_technician_name}", :at => [315, 173]) new
          #pdf.text_box("#{@project.m_technician_name}", :at => [315, 171])
          #pdf.text_box("#{@project.m_technician_name}", :at => [315, 141])
          pdf.text_box("#{@project.m_technician_name}", :at => [315, 154])
        end        
      elsif array.length == 3
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Technician Name", :at => [10, 199], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_technician_name}", :at => [315, 199])
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.font_size 12
          pdf.text_box("Technician Name", :at => [10, 298], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_technician_name}", :at => [315, 298])
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.font_size 12
          pdf.text_box("Technician Name", :at => [10, 298], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_technician_name}", :at => [315, 298])
        else
          pdf.font_size 12
          #pdf.text_box("Name", :at => [10, 184], :style => :bold)
          #pdf.text_box("Name", :at => [10, 154], :style => :bold)
          pdf.text_box("Technician Name", :at => [10, 167], :style => :bold)
          pdf.font_size 10
          #pdf.text_box("#{@project.m_technician_name}", :at => [315, 184])
          #pdf.text_box("#{@project.m_technician_name}", :at => [315, 154])
          pdf.text_box("#{@project.m_technician_name}", :at => [315, 167])
        end        
      else
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Technician Name", :at => [10, 208], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_technician_name}", :at => [315, 208])
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.font_size 12
          pdf.text_box("Technician Name", :at => [10, 310], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_technician_name}", :at => [315, 310])
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.font_size 12
          pdf.text_box("Technician Name", :at => [10, 310], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_technician_name}", :at => [315, 310])
        else
          pdf.font_size 12
          #pdf.text_box("Name", :at => [10, 196], :style => :bold)
          #pdf.text_box("Name", :at => [10, 158], :style => :bold)
          pdf.text_box("Technician Name", :at => [10, 171], :style => :bold)
          pdf.font_size 10
          #pdf.text_box("#{@project.m_technician_name}", :at => [315, 196])
          #pdf.text_box("#{@project.m_technician_name}", :at => [315, 158])
          pdf.text_box("#{@project.m_technician_name}", :at => [315, 171])
        end
      end
    end

    def draw_customer_name(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Customer Name", :at => [10, 171], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_customer_name}", :at => [315, 171])
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.font_size 12
          pdf.text_box("Customer Name", :at => [10, 270], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_customer_name}", :at => [315, 270])
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.font_size 12
          pdf.text_box("Customer Name", :at => [10, 270], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_customer_name}", :at => [315, 270])
        else
          pdf.font_size 12
          pdf.text_box("Customer Name", :at => [10, 139], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_customer_name}", :at => [315, 139])
        end  
      elsif array.length == 3
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Customer Name", :at => [10, 184], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_customer_name}", :at => [315, 184])
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.font_size 12
          pdf.text_box("Customer Name", :at => [10, 283], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_customer_name}", :at => [315, 283])
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.font_size 12
          pdf.text_box("Customer Name", :at => [10, 283], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_customer_name}", :at => [315, 283])
        else
          pdf.font_size 12
          pdf.text_box("Customer Name", :at => [10, 152], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_customer_name}", :at => [315, 152])
        end
      else
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Customer Name", :at => [10, 193], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_customer_name}", :at => [315, 193])
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.font_size 12
          pdf.text_box("Customer Name", :at => [10, 295], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_customer_name}", :at => [315, 295])
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.font_size 12
          pdf.text_box("Customer Name", :at => [10, 295], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_customer_name}", :at => [315, 295])
        else
          pdf.font_size 12
          pdf.text_box("Customer Name", :at => [10, 156], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_customer_name}", :at => [315, 156])
        end
      end        
    end

    def draw_signature(pdf)
      array = @project.m_building.split(",")
      pdf.font_size 12
      if array.length >= 5
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 136])
          image = @project.m_authorization_signature.path
          unless image.blank?
            pdf.image(image, at: [315, 151], :width => 150, :height => 70)
          else
          end
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 225])
          image = @project.m_authorization_signature.path
          unless image.blank?
            pdf.image(image, at: [315, 250], :width => 150, :height => 70)
          else
          end
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 225])
          image = @project.m_authorization_signature.path
          unless image.blank?
            pdf.image(image, at: [315, 250], :width => 150, :height => 70)
          else
          end
        else
          #pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 128]) old
          #pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 126]) #new
          #pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 96])
          pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 94])
          image = @project.m_authorization_signature.path
          unless image.blank?
            #pdf.image(image, at: [315, 153], :width => 150, :height => 70) old
            pdf.image(image, at: [315, 119], :width => 150, :height => 60) #new
          else
          end
        end        
      elsif array.length == 3
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 139])
          image = @project.m_authorization_signature.path
          unless image.blank?
            pdf.image(image, at: [315, 164], :width => 150, :height => 70)
          else
          end
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 238])
          image = @project.m_authorization_signature.path
          unless image.blank?
            pdf.image(image, at: [315, 263], :width => 150, :height => 70)
          else
          end
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 238])
          image = @project.m_authorization_signature.path
          unless image.blank?
            pdf.image(image, at: [315, 263], :width => 150, :height => 70)
          else
          end
        else
          #pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 139])
          #pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 109])
          pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 107])
          image = @project.m_authorization_signature.path
          unless image.blank?
            #pdf.image(image, at: [315, 164], :width => 150, :height => 70)
            #pdf.image(image, at: [315, 134], :width => 150, :height => 70)
            pdf.image(image, at: [315, 132], :width => 150, :height => 60)
          else
          end
        end        
      else
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 148])
          image = @project.m_authorization_signature.path
          unless image.blank?
            pdf.image(image, at: [315, 173], :width => 150, :height => 70)
          else
          end
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 250])
          image = @project.m_authorization_signature.path
          unless image.blank?
            pdf.image(image, at: [315, 275], :width => 150, :height => 70)
          else
          end
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 250])
          image = @project.m_authorization_signature.path
          unless image.blank?
            pdf.image(image, at: [315, 275], :width => 150, :height => 70)
          else
          end
        else
          #pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 151])
          #pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 113])
          pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 111])
          image = @project.m_authorization_signature.path
          unless image.blank?
            #pdf.image(image, at: [315, 176], :width => 150, :height => 70)
            pdf.image(image, at: [315, 136], :width => 150, :height => 60)
          else
          end
        end
      end
    end
    
    def projectcompletion_template
      'three_hundred_dpi/projectcomplettion_template.jpg'
    end
  end
end