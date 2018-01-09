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
      draw_customer_name(pdf)
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

    def draw_customer_name(pdf)
      array = @project.m_building.split(",")      
      if array.length >= 5
        pdf.font_size 12
        pdf.text_box("Customer Name", :at => [10, 484], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_customer_name}", :at => [290, 484])
      elsif array.length == 3
        pdf.font_size 12
        pdf.text_box("Customer Name", :at => [10, 497], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_customer_name}", :at => [290, 497])
      else
        pdf.font_size 12
        pdf.text_box("Customer Name", :at => [10, 509], :style => :bold)
        pdf.font_size 10
        pdf.text_box("#{@project.m_customer_name}", :at => [290, 509])
      end
    end

    def draw_customer_hard_copy_text(pdf)
      #pdf.move_down 170
      array = @project.m_building.split(",")
      pdf.font_size 12
      if array.length >= 5
        pdf.text_box("Customer wants hard copy of inspection report mailed to them at an additional charge. For details, customer will need to contact their sales representative. (if not, a link will be emailed to access LSS Site Surveyor® for you to download the report)", 
                    :at => [10, 466], :align => :justify, :style => :bold) #:at => [10, 253] :at => [10, 319] old, :at => [10, 486] new
      elsif array.length == 3
        pdf.text_box("Customer wants hard copy of inspection report mailed to them at an additional charge. For details, customer will need to contact their sales representative. (if not, a link will be emailed to access LSS Site Surveyor® for you to download the report)", 
                    :at => [10, 479], :align => :justify, :style => :bold)
      else
        pdf.text_box("Customer wants hard copy of inspection report mailed to them at an additional charge. For details, customer will need to contact their sales representative. (if not, a link will be emailed to access LSS Site Surveyor® for you to download the report)", 
                    :at => [10, 491], :align => :justify, :style => :bold)
      end
    end

    def draw_printed_report(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        pdf.font_size 12
        #pdf.text_box("Printed Report", :at => [10, 271], :style => :bold) old
        #pdf.text_box("Printed Report", :at => [10, 438], :style => :bold) new
        pdf.text_box("Printed Report", :at => [10, 418], :style => :bold)
        pdf.font_size 10
        if @project.m_printed_report == "Yes"
          #pdf.text_box("Y", :at => [290, 203])
          #pdf.text_box("Y", :at => [315, 203])
          #pdf.text_box("Y", :at => [315, 271]) old
          #pdf.text_box("Y", :at => [315, 438]) new
          pdf.text_box("Y", :at => [315, 418])
        else 
          #pdf.text_box("N", :at => [290, 203])
          #pdf.text_box("N", :at => [315, 203])
          #pdf.text_box("N", :at => [315, 271]) old
          #pdf.text_box("N", :at => [315, 438]) new
          pdf.text_box("N", :at => [315, 418])
        end
      elsif array.length == 3
        pdf.font_size 12
        pdf.text_box("Printed Report", :at => [10, 431], :style => :bold)
        pdf.font_size 10
        if @project.m_printed_report == "Yes"
          pdf.text_box("Y", :at => [315, 431])
        else
          pdf.text_box("N", :at => [315, 431])
        end
      else
        pdf.font_size 12
        pdf.text_box("Printed Report", :at => [10, 443], :style => :bold)
        pdf.font_size 10
        if @project.m_printed_report == "Yes"
          pdf.text_box("Y", :at => [315, 443])
        else
          pdf.text_box("N", :at => [315, 443])
        end
      end
    end

    def draw_customer_requests_text(pdf)
      pdf.font_size 12
      array = @project.m_building.split(",")
      if array.length >= 5
        pdf.text_box("Customer requests the hand mapped drawings be converted to AutoCAD and agrees to an additional charge. For details, customer will need to contact their sales representative.",
                   :at => [10, 400], :align => :justify, :style => :bold) #:at => [10, 180] , :at => [10, 253] old, :at => [10, 420] new  
      elsif array.length == 3
        pdf.text_box("Customer requests the hand mapped drawings be converted to AutoCAD and agrees to an additional charge. For details, customer will need to contact their sales representative.",
                   :at => [10, 413], :align => :justify, :style => :bold)
      else
        pdf.text_box("Customer requests the hand mapped drawings be converted to AutoCAD and agrees to an additional charge. For details, customer will need to contact their sales representative.",
                   :at => [10, 425], :align => :justify, :style => :bold)
      end
    end

    def draw_autocad(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        pdf.font_size 12
        #pdf.text_box("AutoCAD", :at => [10, 143], :style => :bold) old
        #pdf.text_box("AutoCAD", :at => [10, 387], :style => :bold) new
        pdf.text_box("AutoCAD", :at => [10, 367], :style => :bold)
        pdf.font_size 10
        if @project.m_autocad == "Yes"
          #pdf.text_box("Y", :at => [290, 143]) old
          #pdf.text_box("Y", :at => [315, 387]) new
          pdf.text_box("Y", :at => [315, 367])
        else 
          #pdf.text_box("N", :at => [290, 143]) old
          #pdf.text_box("N", :at => [315, 387]) new
          pdf.text_box("N", :at => [315, 367])
        end
      elsif array.length == 3
        pdf.font_size 12
        pdf.text_box("AutoCAD", :at => [10, 380], :style => :bold)
        pdf.font_size 10
        if @project.m_autocad == "Yes"
          pdf.text_box("Y", :at => [315, 380])
        else
          pdf.text_box("N", :at => [315, 380])
        end
      else
        pdf.font_size 12
        pdf.text_box("AutoCAD", :at => [10, 392], :style => :bold)
        pdf.font_size 10
        if @project.m_autocad == "Yes"
          pdf.text_box("Y", :at => [315, 392])
        else
          pdf.text_box("N", :at => [315, 392])
        end
      end
    end

    def draw_containment_tent_used(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Containment Tent Used?", :at => [10, 302], :style => :bold)
          pdf.font_size 10
          if @project.m_containment_tent_used == "Yes"
            pdf.text_box("Y", :at => [315, 302])
          elsif @project.m_containment_tent_used == "No"
            pdf.text_box("N", :at => [315, 302])
          else
            pdf.text_box("NA", :at => [315, 302])
          end
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.font_size 12
          pdf.text_box("Containment Tent Used?", :at => [10, 302], :style => :bold)
          pdf.font_size 10
          if @project.m_containment_tent_used == "Yes"
            pdf.text_box("Y", :at => [315, 302])
          elsif @project.m_containment_tent_used == "No"
            pdf.text_box("N", :at => [315, 302])
          else
            pdf.text_box("NA", :at => [315, 302])
          end
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.font_size 12
          pdf.text_box("Containment Tent Used?", :at => [10, 302], :style => :bold)
          pdf.font_size 10
          if @project.m_containment_tent_used == "Yes"
            pdf.text_box("Y", :at => [315, 302])
          elsif @project.m_containment_tent_used == "No"
            pdf.text_box("N", :at => [315, 302])
          else
            pdf.text_box("NA", :at => [315, 302])
          end
        else
          pdf.font_size 12
          #pdf.text_box("Containment Tent Used?", :at => [10, 58], :style => :bold) #53
          #pdf.text_box("Containment Tent Used?", :at => [10, 140], :style => :bold) #53, 135 old
          #pdf.text_box("Containment Tent Used?", :at => [10, 307], :style => :bold) new
          #pdf.text_box("Containment Tent Used?", :at => [10, 305], :style => :bold)
          pdf.text_box("Containment Tent Used?", :at => [10, 272], :style => :bold)
          pdf.font_size 10
          if @project.m_containment_tent_used == "Yes"
            #pdf.text_box("Y", :at => [290, 58])
            #pdf.text_box("Y", :at => [315, 58])
            #pdf.text_box("Y", :at => [315, 140]) old
            #pdf.text_box("Y", :at => [315, 307]) new
            #pdf.text_box("Y", :at => [315, 305])
            pdf.text_box("Y", :at => [315, 272])
          elsif @project.m_containment_tent_used == "No"
            #pdf.text_box("N", :at => [290, 58])
            #pdf.text_box("N", :at => [315, 58])
            #pdf.text_box("N", :at => [315, 140]) old
            #pdf.text_box("N", :at => [315, 307]) new
            #pdf.text_box("N", :at => [315, 305])
            pdf.text_box("N", :at => [315, 272])
          else
            #pdf.text_box("NA", :at => [315, 305])
            pdf.text_box("NA", :at => [315, 272])
          end
        end      
      elsif array.length == 3
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Containment Tent Used?", :at => [10, 315], :style => :bold)
          pdf.font_size 10
          if @project.m_containment_tent_used == "Yes"
            pdf.text_box("Y", :at => [315, 315])
          elsif @project.m_containment_tent_used == "No"
            pdf.text_box("N", :at => [315, 315])
          else
            pdf.text_box("NA", :at => [315, 315])
          end
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.font_size 12
          pdf.text_box("Containment Tent Used?", :at => [10, 315], :style => :bold)
          pdf.font_size 10
          if @project.m_containment_tent_used == "Yes"
            pdf.text_box("Y", :at => [315, 315])
          elsif @project.m_containment_tent_used == "No"
            pdf.text_box("N", :at => [315, 315])
          else
            pdf.text_box("NA", :at => [315, 315])
          end
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.font_size 12
          pdf.text_box("Containment Tent Used?", :at => [10, 315], :style => :bold)
          pdf.font_size 10
          if @project.m_containment_tent_used == "Yes"
            pdf.text_box("Y", :at => [315, 315])
          elsif @project.m_containment_tent_used == "No"
            pdf.text_box("N", :at => [315, 315])
          else
            pdf.text_box("NA", :at => [315, 315])
          end
        else
          pdf.font_size 12
          #pdf.text_box("Containment Tent Used?", :at => [10, 318], :style => :bold)
          pdf.text_box("Containment Tent Used?", :at => [10, 285], :style => :bold)
          pdf.font_size 10
          if @project.m_containment_tent_used == "Yes"
            #pdf.text_box("Y", :at => [315, 318])
            pdf.text_box("Y", :at => [315, 285])
          elsif @project.m_containment_tent_used == "No"
            #pdf.text_box("N", :at => [315, 318])
            pdf.text_box("N", :at => [315, 285])
          else
            pdf.text_box("NA", :at => [315, 285])
          end
        end
      else
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Containment Tent Used?", :at => [10, 327], :style => :bold)
          pdf.font_size 10
          if @project.m_containment_tent_used == "Yes"
            pdf.text_box("Y", :at => [315, 327])
          elsif @project.m_containment_tent_used == "No"
            pdf.text_box("N", :at => [315, 327])
          else
            pdf.text_box("NA", :at => [315, 327])
          end
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.font_size 12
          pdf.text_box("Containment Tent Used?", :at => [10, 327], :style => :bold)
          pdf.font_size 10
          if @project.m_containment_tent_used == "Yes"
            pdf.text_box("Y", :at => [315, 327])
          elsif @project.m_containment_tent_used == "No"
            pdf.text_box("N", :at => [315, 327])
          else
            pdf.text_box("NA", :at => [315, 327])
          end
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.font_size 12
          pdf.text_box("Containment Tent Used?", :at => [10, 327], :style => :bold)
          pdf.font_size 10
          if @project.m_containment_tent_used == "Yes"
            pdf.text_box("Y", :at => [315, 327])
          elsif @project.m_containment_tent_used == "No"
            pdf.text_box("N", :at => [315, 327])
          else
            pdf.text_box("NA", :at => [315, 327])
          end
        else
          pdf.font_size 12
          #pdf.text_box("Containment Tent Used?", :at => [10, 330], :style => :bold)
          pdf.text_box("Containment Tent Used?", :at => [10, 297], :style => :bold)
          pdf.font_size 10
          if @project.m_containment_tent_used == "Yes"
            #pdf.text_box("Y", :at => [315, 330])
            pdf.text_box("Y", :at => [315, 297])
          elsif @project.m_containment_tent_used == "No"
            #pdf.text_box("N", :at => [315, 330])
            pdf.text_box("N", :at => [315, 297])
          else
            #pdf.text_box("NA", :at => [315, 330])
            pdf.text_box("NA", :at => [315, 297])
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
          pdf.text_box("INSPECTION OVER BASE BID:", :at => [10, 279], :style => :bold)
          pdf.text_box("I acknowledge that the damper count stated on the proposal has", :at => [192, 279], :align => :justify)
          pdf.text_box("been reached. I have the authority to authorize the continuation of the damper project to completion or to the new total damper count stated below. Your signature below will act as official approval - no further documents, purchase orders, or other forms shall be construed to modify this approval.",
                     :at => [10, 264], :align => :justify)
        elsif @project.m_servicetype == "Firestop Survey"
        elsif @project.m_servicetype == "Firestop Installation"
        else
          #pdf.text_box("INSPECTION OVER BASE BID:", :at => [10, 282], :style => :bold) #110 :at => [10, 120] old, :at => [10, 284] new
          pdf.text_box("INSPECTION OVER BASE BID:", :at => [10, 249], :style => :bold) #
          #pdf.text_box("I acknowledge that the damper count stated on the proposal has", :at => [192, 282], :align => :justify)  #:at => [10, 110], :at => [192, 120] old,  :at => [192, 284] new
          pdf.text_box("I acknowledge that the damper count stated on the proposal has", :at => [192, 249], :align => :justify)
          #pdf.text_box("been reached. I have the authority to authorize the continuation of the damper project to completion or to the new total damper count stated below. Your signature below will act as official approval - no further documents, purchase orders, or other forms shall be construed to modify this approval.", :at => [10, 267], :align => :justify) #95 :at => [10, 105] old, :at => [10, 269] new
          pdf.text_box("been reached. I have the authority to authorize the continuation of the damper project to completion or to the new total damper count stated below. Your signature below will act as official approval - no further documents, purchase orders, or other forms shall be construed to modify this approval.", 
                       :at => [10, 234], :align => :justify)
        end
      elsif array.length == 3
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.text_box("INSPECTION OVER BASE BID:", :at => [10, 292], :style => :bold)
          pdf.text_box("I acknowledge that the damper count stated on the proposal has", :at => [192, 292], :align => :justify)
          pdf.text_box("been reached. I have the authority to authorize the continuation of the damper project to completion or to the new total damper count stated below. Your signature below will act as official approval - no further documents, purchase orders, or other forms shall be construed to modify this approval.",
                     :at => [10, 277], :align => :justify)
        elsif @project.m_servicetype == "Firestop Survey"
        elsif @project.m_servicetype == "Firestop Installation"  
        else
          #pdf.text_box("INSPECTION OVER BASE BID:", :at => [10, 295], :style => :bold)
          pdf.text_box("INSPECTION OVER BASE BID:", :at => [10, 262], :style => :bold)
          #pdf.text_box("I acknowledge that the damper count stated on the proposal has", :at => [192, 295], :align => :justify)
          pdf.text_box("I acknowledge that the damper count stated on the proposal has", :at => [192, 262], :align => :justify)
          #pdf.text_box("been reached. I have the authority to authorize the continuation of the damper project to completion or to the new total damper count stated below. Your signature below will act as official approval - no further documents, purchase orders, or other forms shall be construed to modify this approval.", :at => [10, 280], :align => :justify)
          pdf.text_box("been reached. I have the authority to authorize the continuation of the damper project to completion or to the new total damper count stated below. Your signature below will act as official approval - no further documents, purchase orders, or other forms shall be construed to modify this approval.", 
                       :at => [10, 247], :align => :justify)
        end        
      else
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.text_box("INSPECTION OVER BASE BID:", :at => [10, 304], :style => :bold)
          pdf.text_box("I acknowledge that the damper count stated on the proposal has", :at => [192, 304], :align => :justify)
          pdf.text_box("been reached. I have the authority to authorize the continuation of the damper project to completion or to the new total damper count stated below. Your signature below will act as official approval - no further documents, purchase orders, or other forms shall be construed to modify this approval.",
                     :at => [10, 289], :align => :justify)
        elsif @project.m_servicetype == "Firestop Survey"
        elsif @project.m_servicetype == "Firestop Installation"  
        else
          #pdf.text_box("INSPECTION OVER BASE BID:", :at => [10, 307], :style => :bold)
          pdf.text_box("INSPECTION OVER BASE BID:", :at => [10, 274], :style => :bold)
          #pdf.text_box("I acknowledge that the damper count stated on the proposal has", :at => [192, 307], :align => :justify)
          pdf.text_box("I acknowledge that the damper count stated on the proposal has", :at => [192, 274], :align => :justify)
          #pdf.text_box("been reached. I have the authority to authorize the continuation of the damper project to completion or to the new total damper count stated below. Your signature below will act as official approval - no further documents, purchase orders, or other forms shall be construed to modify this approval.", :at => [10, 292], :align => :justify)
          pdf.text_box("been reached. I have the authority to authorize the continuation of the damper project to completion or to the new total damper count stated below. Your signature below will act as official approval - no further documents, purchase orders, or other forms shall be construed to modify this approval.", 
                      :at => [10, 259], :align => :justify)
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
          pdf.text_box("Base Bid Count", :at => [10, 216], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 216])
        elsif @project.m_servicetype == "Firestop Survey"
        elsif @project.m_servicetype == "Firestop Installation"
        else
          pdf.font_size 12
          #pdf.text_box("Base Bid Count", :at => [10, 11], :style => :bold)
          #pdf.text_box("Base Bid Count", :at => [10, 60], :style => :bold) #47 old
          #pdf.text_box("Base Bid Count", :at => [10, 221], :style => :bold) new
          #pdf.text_box("Base Bid Count", :at => [10, 219], :style => :bold)
          #pdf.text_box("Base Bid Count", :at => [10, 189], :style => :bold)
          pdf.text_box("Base Bid Count", :at => [10, 181], :style => :bold)
          pdf.font_size 10
          #pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 11])
          #pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 60]) old
          #pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 221]) new
          #pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 219])
          #pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 189])
          pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 181])
        end        
      elsif array.length == 3
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Base Bid Count", :at => [10, 229], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 229])
        elsif @project.m_servicetype == "Firestop Survey"
        elsif @project.m_servicetype == "Firestop Installation"  
        else
          pdf.font_size 12
          #pdf.text_box("Base Bid Count", :at => [10, 232], :style => :bold)
          #pdf.text_box("Base Bid Count", :at => [10, 202], :style => :bold)
          pdf.text_box("Base Bid Count", :at => [10, 194], :style => :bold)
          pdf.font_size 10
          #pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 232])
          pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 194])
        end
      else
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Base Bid Count", :at => [10, 241], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 241])
        elsif @project.m_servicetype == "Firestop Survey"
        elsif @project.m_servicetype == "Firestop Installation"  
        else
          pdf.font_size 12
          #pdf.text_box("Base Bid Count", :at => [10, 244], :style => :bold)
          pdf.text_box("Base Bid Count", :at => [10, 206], :style => :bold)
          pdf.font_size 10
          #pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 244])
          pdf.text_box("#{@project.m_base_bid_count}", :at => [315, 206])
        end
      end
    end

    def draw_new_total_authorized_damper_bid(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("New Total Authorized Firedoor Bid", :at => [10, 201], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 201])
        elsif @project.m_servicetype == "Firestop Survey"
        elsif @project.m_servicetype == "Firestop Installation"  
        else
          pdf.font_size 12
          #pdf.text_box("New Total Authorized Damper Bid", :at => [10, 45], :style => :bold) #32 old
          #pdf.text_box("New Total Authorized Damper Bid", :at => [10, 206], :style => :bold) new
          if @project.m_servicetype == "Damper Inspection"
            #pdf.text_box("New Total Authorized Damper Inspected Bid", :at => [10, 204], :style => :bold)
            #pdf.text_box("New Total Authorized Damper Inspected Bid", :at => [10, 174], :style => :bold)
            pdf.text_box("New Total Authorized Damper Inspected Bid", :at => [10, 166], :style => :bold)
          else
            #pdf.text_box("New Total Authorized Damper Repaired Bid", :at => [10, 204], :style => :bold)
            #pdf.text_box("New Total Authorized Damper Repaired Bid", :at => [10, 174], :style => :bold)
            pdf.text_box("New Total Authorized Damper Repaired Bid", :at => [10, 166], :style => :bold)
          end
          pdf.font_size 10
          #pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 45]) old
          #pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 206]) new
          #pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 204])
          #pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 174])
          pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 166])
        end         
      elsif array.length == 3
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("New Total Authorized Firedoor Bid", :at => [10, 214], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 214])
        elsif @project.m_servicetype == "Firestop Survey"
        elsif @project.m_servicetype == "Firestop Installation"  
        else
          pdf.font_size 12
          if @project.m_servicetype == "Damper Inspection"
            #pdf.text_box("New Total Authorized Damper Inspected Bid", :at => [10, 217], :style => :bold)
            #pdf.text_box("New Total Authorized Damper Inspected Bid", :at => [10, 187], :style => :bold)
            pdf.text_box("New Total Authorized Damper Inspected Bid", :at => [10, 179], :style => :bold)
          else
            #pdf.text_box("New Total Authorized Damper Repaired Bid", :at => [10, 217], :style => :bold)
            #pdf.text_box("New Total Authorized Damper Repaired Bid", :at => [10, 187], :style => :bold)
            pdf.text_box("New Total Authorized Damper Repaired Bid", :at => [10, 179], :style => :bold)
          end
          pdf.font_size 10
          #pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 217])
          #pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 187])
          pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 179])
        end        
      else
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("New Total Authorized Firedoor Bid", :at => [10, 226], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 226])
        elsif @project.m_servicetype == "Firestop Survey"
        elsif @project.m_servicetype == "Firestop Installation"  
        else
          pdf.font_size 12
          if @project.m_servicetype == "Damper Inspection"
            #pdf.text_box("New Total Authorized Damper Inspected Bid", :at => [10, 229], :style => :bold)
            #pdf.text_box("New Total Authorized Damper Inspected Bid", :at => [10, 191], :style => :bold)
            pdf.text_box("New Total Authorized Damper Inspected Bid", :at => [10, 191], :style => :bold)
          else
            #pdf.text_box("New Total Authorized Damper Repaired Bid", :at => [10, 229], :style => :bold)
            #pdf.text_box("New Total Authorized Damper Repaired Bid", :at => [10, 191], :style => :bold)
            pdf.text_box("New Total Authorized Damper Repaired Bid", :at => [10, 191], :style => :bold)
          end
          pdf.font_size 10
          #pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 229])
          #pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 191])
          pdf.text_box("#{@project.m_new_total_authorized_damper_bid}", :at => [315, 191])
        end        
      end
    end
    
    def draw_date(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Date", :at => [10, 186], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 186])
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.font_size 12
          pdf.text_box("Date", :at => [10, 282], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 282])
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.font_size 12
          pdf.text_box("Date", :at => [10, 282], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 282])
        else
          pdf.font_size 12
          #pdf.text_box("Date", :at => [10, 30], :style => :bold) #17 old
          #pdf.text_box("Date", :at => [10, 188], :style => :bold) new
          #pdf.text_box("Date", :at => [10, 186], :style => :bold)
          #pdf.text_box("Date", :at => [10, 156], :style => :bold)
          pdf.text_box("Date", :at => [10, 151], :style => :bold)
          pdf.font_size 10
          #pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 30]) old
          #pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 188]) new
          #pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 186])
          #pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 156])
          pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 151])
        end        
      elsif array.length == 3
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Date", :at => [10, 199], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 199])
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.font_size 12
          pdf.text_box("Date", :at => [10, 295], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 295])
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.font_size 12
          pdf.text_box("Date", :at => [10, 295], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 295])
        else
          pdf.font_size 12
          #pdf.text_box("Date", :at => [10, 199], :style => :bold)
          #pdf.text_box("Date", :at => [10, 169], :style => :bold)
          pdf.text_box("Date", :at => [10, 164], :style => :bold)
          pdf.font_size 10
          #pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 199])
          #pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 169])
          pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 164])
        end        
      else
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Date", :at => [10, 211], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 211])
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.font_size 12
          pdf.text_box("Date", :at => [10, 307], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 307])
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.font_size 12
          pdf.text_box("Date", :at => [10, 307], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 307])
        else
          pdf.font_size 12
          #pdf.text_box("Date", :at => [10, 211], :style => :bold)
          #pdf.text_box("Date", :at => [10, 173], :style => :bold)
          pdf.text_box("Date", :at => [10, 176], :style => :bold)
          pdf.font_size 10
          #pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 211])
          #pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 173])
          pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [315, 176])
        end        
      end
    end

    def draw_tech_name(pdf)
      array = @project.m_building.split(",")
      if array.length >= 5
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Name", :at => [10, 171], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_technician_name}", :at => [315, 171])
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.font_size 12
          pdf.text_box("Name", :at => [10, 267], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_technician_name}", :at => [315, 267])
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.font_size 12
          pdf.text_box("Name", :at => [10, 267], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_technician_name}", :at => [315, 267])
        else
          pdf.font_size 12
          #pdf.text_box("Name", :at => [10, 15], :style => :bold) #2 old
          #pdf.text_box("Name", :at => [10, 173], :style => :bold) new
          #pdf.text_box("Name", :at => [10, 171], :style => :bold)
          #pdf.text_box("Name", :at => [10, 141], :style => :bold)
          pdf.text_box("Name", :at => [10, 136], :style => :bold)
          pdf.font_size 10
          #pdf.text_box("#{@project.m_technician_name}", :at => [315, 15]) old
          #pdf.text_box("#{@project.m_technician_name}", :at => [315, 173]) new
          #pdf.text_box("#{@project.m_technician_name}", :at => [315, 171])
          #pdf.text_box("#{@project.m_technician_name}", :at => [315, 141])
          pdf.text_box("#{@project.m_technician_name}", :at => [315, 136])
        end        
      elsif array.length == 3
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Name", :at => [10, 184], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_technician_name}", :at => [315, 184])
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.font_size 12
          pdf.text_box("Name", :at => [10, 280], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_technician_name}", :at => [315, 280])
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.font_size 12
          pdf.text_box("Name", :at => [10, 280], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_technician_name}", :at => [315, 280])
        else
          pdf.font_size 12
          #pdf.text_box("Name", :at => [10, 184], :style => :bold)
          #pdf.text_box("Name", :at => [10, 154], :style => :bold)
          pdf.text_box("Name", :at => [10, 149], :style => :bold)
          pdf.font_size 10
          #pdf.text_box("#{@project.m_technician_name}", :at => [315, 184])
          #pdf.text_box("#{@project.m_technician_name}", :at => [315, 154])
          pdf.text_box("#{@project.m_technician_name}", :at => [315, 149])
        end        
      else
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.font_size 12
          pdf.text_box("Name", :at => [10, 196], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_technician_name}", :at => [315, 196])
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.font_size 12
          pdf.text_box("Name", :at => [10, 292], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_technician_name}", :at => [315, 292])
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.font_size 12
          pdf.text_box("Name", :at => [10, 292], :style => :bold)
          pdf.font_size 10
          pdf.text_box("#{@project.m_technician_name}", :at => [315, 292])
        else
          pdf.font_size 12
          #pdf.text_box("Name", :at => [10, 196], :style => :bold)
          #pdf.text_box("Name", :at => [10, 158], :style => :bold)
          pdf.text_box("Name", :at => [10, 161], :style => :bold)
          pdf.font_size 10
          #pdf.text_box("#{@project.m_technician_name}", :at => [315, 196])
          #pdf.text_box("#{@project.m_technician_name}", :at => [315, 158])
          pdf.text_box("#{@project.m_technician_name}", :at => [315, 161])
        end
      end
    end

    def draw_signature(pdf)
      array = @project.m_building.split(",")
      pdf.font_size 12
      if array.length >= 5
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.text_box("Authorization to inspect all Firedoor to completion", :at => [10, 126])
          image = @project.m_authorization_signature.path
          unless image.blank?
            pdf.image(image, at: [315, 151], :width => 150, :height => 70)
          else
          end
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.text_box("Authorization to inspect all Firestop to completion", :at => [10, 222])
          image = @project.m_authorization_signature.path
          unless image.blank?
            pdf.image(image, at: [315, 247], :width => 150, :height => 70)
          else
          end
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.text_box("Authorization to inspect all Firestop to completion", :at => [10, 222])
          image = @project.m_authorization_signature.path
          unless image.blank?
            pdf.image(image, at: [315, 247], :width => 150, :height => 70)
          else
          end
        else
          #pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 128]) old
          #pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 126]) #new
          #pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 96])
          pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 91])
          image = @project.m_authorization_signature.path
          unless image.blank?
            #pdf.image(image, at: [315, 153], :width => 150, :height => 70) old
            pdf.image(image, at: [315, 116], :width => 150, :height => 60) #new
          else
          end
        end        
      elsif array.length == 3
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.text_box("Authorization to inspect all Firedoor to completion", :at => [10, 139])
          image = @project.m_authorization_signature.path
          unless image.blank?
            pdf.image(image, at: [315, 164], :width => 150, :height => 70)
          else
          end
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.text_box("Authorization to inspect all Firestop to completion", :at => [10, 235])
          image = @project.m_authorization_signature.path
          unless image.blank?
            pdf.image(image, at: [315, 260], :width => 150, :height => 70)
          else
          end
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.text_box("Authorization to inspect all Firestop to completion", :at => [10, 235])
          image = @project.m_authorization_signature.path
          unless image.blank?
            pdf.image(image, at: [315, 260], :width => 150, :height => 70)
          else
          end
        else
          #pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 139])
          #pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 109])
          pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 104])
          image = @project.m_authorization_signature.path
          unless image.blank?
            #pdf.image(image, at: [315, 164], :width => 150, :height => 70)
            #pdf.image(image, at: [315, 134], :width => 150, :height => 70)
            pdf.image(image, at: [315, 129], :width => 150, :height => 60)
          else
          end
        end        
      else
        if @project.m_servicetype == "Firedoor Inspection"
          pdf.text_box("Authorization to inspect all Firedoor to completion", :at => [10, 151])
          image = @project.m_authorization_signature.path
          unless image.blank?
            pdf.image(image, at: [315, 176], :width => 150, :height => 70)
          else
          end
        elsif @project.m_servicetype == "Firestop Survey"
          pdf.text_box("Authorization to inspect all Firedoor to completion", :at => [10, 247])
          image = @project.m_authorization_signature.path
          unless image.blank?
            pdf.image(image, at: [315, 272], :width => 150, :height => 70)
          else
          end
        elsif @project.m_servicetype == "Firestop Installation"
          pdf.text_box("Authorization to inspect all Firestop to completion", :at => [10, 247])
          image = @project.m_authorization_signature.path
          unless image.blank?
            pdf.image(image, at: [315, 272], :width => 150, :height => 70)
          else
          end
        else
          #pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 151])
          #pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 113])
          pdf.text_box("Authorization to inspect all dampers to completion", :at => [10, 116])
          image = @project.m_authorization_signature.path
          unless image.blank?
            #pdf.image(image, at: [315, 176], :width => 150, :height => 70)
            pdf.image(image, at: [315, 141], :width => 150, :height => 60)
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