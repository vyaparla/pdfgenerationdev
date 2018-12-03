module Report
  class AcknowledgeDetailPage
  	include NewPageWritable

    def initialize(project)
      @project = project
    end

    def write(pdf)
      super
      draw_acknowledge_heading(pdf)
      draw_acknowledge_base_on_project_servicetype(pdf)
      # draw_acknowledge_blueprints(pdf)
      # draw_acknowledge_replacement_checklist(pdf)
      # draw_acknowledge_facility_items(pdf)
      # draw_acknowledge_emailed_reports(pdf)
      # draw_acknowledge_daily_basis(pdf)
      # draw_acknowledge_containment_tent_used(pdf)
      # draw_acknowledge_date(pdf)
      # draw_acknowledge_tech_name(pdf)
      # draw_acknowledge_signature(pdf)
    end

  private

    def project
      @project
    end

    def draw_acknowledge_heading(pdf)
      pdf.move_down 200
      pdf.font_size 15
      #pdf.text_box("I ACKNOWLEDGE THE FOLLOWING", :at => [0, 610], :style => :bold) old
      pdf.text_box("I ACKNOWLEDGE THE FOLLOWING", :at => [0, 628], :style => :bold)
      #pdf.stroke_horizontal_rule
    end

    def draw_acknowledge_base_on_project_servicetype(pdf)
      if @project.m_servicetype == "Damper Inspection" || @project.m_servicetype == "Damper Repair"
        
        #acknowledge1
        pdf.font_size 12        
        pdf.text_box("1. Inspector has mapped the damper/door", :at => [8, 605], :style => :bold, :align => :justify)        
        pdf.text_box("locations on customer provided blueprints or", :at => [8, 590], :style => :bold, :align => :justify)        
        pdf.text_box("facility layout and returned customer drawings", :at => [8, 575], :style => :bold, :align => :justify)  
        pdf.font_size 10
        if @project.m_blueprints_facility == "Yes"          
          pdf.text_box("Y", :at => [375, 605])
        elsif @project.m_blueprints_facility == "No"          
          pdf.text_box("N", :at => [375, 605])
        else          
          pdf.text_box("NA", :at => [375, 605])
        end

        #acknowledge2
        pdf.font_size 12        
        pdf.text_box("2. Damper actuator replacement checklist provided", :at => [8, 557], :style => :bold, :align => :justify)# Changed Damper actutor on 30-11-2018
        pdf.text_box("(if replacement performed)", :at => [8, 542], :style => :bold, :align => :justify)
        pdf.font_size 10
        if @project.m_replacement_checklist == "Yes"          
          pdf.text_box("Y", :at => [375, 557])
        elsif @project.m_replacement_checklist == "No"
          pdf.text_box("N", :at => [375, 557])
        else
          pdf.text_box("NA", :at => [375, 557])
        end

        #acknowledge3
        pdf.font_size 12
        pdf.text_box("3. Any two-way radios, keys, badges, ladders, or any", :at => [8, 524], :style => :bold, :align => :justify)
        pdf.text_box("other facility items used during the project have been", :at => [8, 509], :style => :bold, :align => :justify)
        pdf.font_size 10
        if @project.m_facility_items == "Yes"
          pdf.text_box("Y", :at => [375, 524])
        elsif  @project.m_facility_items == "No"
          pdf.text_box("N", :at => [375, 524])
        else
          pdf.text_box("NA", :at => [375, 524])
        end

        #acknowledge4
        pdf.font_size 12
        #pdf.text_box("4. Customer understands that a link will be emailed to", :at => [8, 473], :style => :bold, :align => :justify) old
        #pdf.text_box("4. Customer understands that a link will be emailed to", :at => [8, 491], :style => :bold, :align => :justify) #new
        pdf.text_box("4. I understand a link will be emailed to me with", :at => [8, 491], :style => :bold, :align => :justify) # Changed on 30-11-2018
        #pdf.text_box("them with access to their inspection reports on", :at => [8, 458], :style => :bold, :align => :justify) old
        #pdf.text_box("them with access to their inspection reports on", :at => [8, 476], :style => :bold, :align => :justify) #new
        pdf.text_box("web-based access to this damper report on the", :at => [8, 476], :style => :bold, :align => :justify) # Changed on 30-11-2018
        #pdf.text_box("their own web-based customer portal.", :at => [8, 443], :style => :bold, :align => :justify) old
        #pdf.text_box("their own web-based customer portal.", :at => [8, 461], :style => :bold, :align => :justify) #new
        pdf.text_box("customer portal.", :at => [8, 461], :style => :bold, :align => :justify) # Changed on 30-11-2018

        pdf.font_size 10
        if @project.m_emailed_reports == "Yes"
          #pdf.text_box("Y", :at => [375, 473]) old
          pdf.text_box("Y", :at => [375, 491]) #new
        elsif @project.m_emailed_reports == "No"
          #pdf.text_box("N", :at => [375, 473]) old
          pdf.text_box("N", :at => [375, 491]) #new
        else
          #pdf.text_box("NA", :at => [375, 473]) old
          pdf.text_box("NA", :at => [375, 491]) #new
        end

        #acknowledge5
        pdf.font_size 12
        #pdf.text_box("5. Technician has kept me informed on a daily basis of", :at => [8, 425], :style => :bold, :align => :justify) old
        pdf.text_box("5. Technician has kept me informed on a daily basis of", :at => [8, 443], :style => :bold, :align => :justify) #new
        #pdf.text_box("the project status and has made me aware of any and", :at => [8, 410], :style => :bold, :align => :justify) old
        pdf.text_box("the project status and has made me aware of any and", :at => [8, 428], :style => :bold, :align => :justify) #new
        #pdf.text_box("all situations requiring my attention.", :at => [8, 395], :style => :bold, :align => :justify) old
        pdf.text_box("all situations requiring my attention.", :at => [8, 413], :style => :bold, :align => :justify) #new
        pdf.font_size 10
        if @project.m_daily_basis == "Yes"
          #pdf.text_box("Y", :at => [375, 425]) old
          pdf.text_box("Y", :at => [375, 443]) #new
        elsif @project.m_daily_basis == "No"
          #pdf.text_box("N", :at => [375, 425]) old
          pdf.text_box("N", :at => [375, 443]) #new
        else
          #pdf.text_box("NA", :at => [375, 425]) old
          pdf.text_box("NA", :at => [375, 443]) #new
        end

        #acknowledge6
        pdf.font_size 12
        #pdf.text_box("6. Containment Tent Used?", :at => [8, 377], :style => :bold) old

        #pdf.text_box("6. Containment Tent Used?", :at => [8, 395], :style => :bold) #new #06-09-2018: Changed as per the client requirement of LP-275
        pdf.text_box("6. # of days containment tent used", :at => [8, 395], :style => :bold)

        pdf.font_size 10

        pdf.text_box("#{@project.m_containment_tent_used}", :at => [375, 395]) #06-09-2018: Changed as per the client requirement of LP-275

        # if @project.m_containment_tent_used == "Yes"
        #   #pdf.text_box("Y", :at => [375, 377]) old
        #   pdf.text_box("Y", :at => [375, 395]) #new
        # elsif @project.m_containment_tent_used == "No"
        #   #pdf.text_box("N", :at => [375, 377]) old
        #   pdf.text_box("N", :at => [375, 395]) #new
        # else
        #   #pdf.text_box("NA", :at => [375, 377]) old
        #   pdf.text_box("NA", :at => [375, 395]) #new
        # end

        #acknowledgeDate
        pdf.font_size 12
        #pdf.text_box("Date", :at => [8, 357], :style => :bold) old
        pdf.text_box("Date", :at => [8, 375], :style => :bold) #new
        pdf.font_size 10
        #pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [375, 357]) old
        pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [375, 375]) #new 

        #acknowledgeTech_name
        # pdf.font_size 12
        # #pdf.text_box("Name", :at => [8, 337], :style => :bold) old
        # pdf.text_box("Technician Name", :at => [8, 355], :style => :bold) #new
        # pdf.font_size 10
        # #pdf.text_box("#{@project.m_technician_name}", :at => [375, 337]) old
        # pdf.text_box("#{@project.m_technician_name}", :at => [375, 355]) #new

        #acknowledgeCustomer_name
        pdf.font_size 12
        #pdf.text_box("Name", :at => [8, 337], :style => :bold) old
        #pdf.text_box("Contact Name", :at => [8, 340], :style => :bold) #new
        pdf.text_box("Contact Name", :at => [8, 355], :style => :bold) #Changed on 30-11-2018
        pdf.font_size 10
        #pdf.text_box("#{@project.m_technician_name}", :at => [375, 337]) old
        #pdf.text_box("#{@project.m_customer_name}", :at => [375, 340]) #new
        pdf.text_box("#{@project.m_customer_name}", :at => [375, 355]) #Changed on 30-11-2018

        #acknowledgeSignature
        pdf.font_size 12
        #pdf.text_box("Signature", :at => [8, 287], :style => :bold) old
        pdf.text_box("Contact Signature", :at => [8, 300], :style => :bold) #new
        image = @project.m_authorization_signature.path
        unless image.blank?
          #pdf.image(image, at: [375, 317], :width => 150, :height => 70) old
          #pdf.image(image, at: [375, 335], :width => 150, :height => 70) #new
          pdf.image(image, at: [375, 330], :width => 150, :height => 60) #new
        else
        end

        #acknowledgeTech_name
        pdf.font_size 12
        pdf.text_box("Technician Name", :at => [8, 250], :style => :bold) #Added on 30-11-2018
        pdf.text_box("#{@project.m_technician_name}", :at => [375, 250]) #Added on 30-11-2018

        #acknowledgeTechnicianSignature
        pdf.font_size 12
        pdf.text_box("Technician Signature", :at => [8, 200], :style => :bold) #Added on 30-11-2018        
        techniciansignature = @project.m_technician_signature.path
        unless techniciansignature.blank?
          pdf.image(techniciansignature, at: [375, 220], :width => 150, :height => 60)
        end

      elsif @project.m_servicetype == "Firedoor Inspection"
        
        #acknowledge1
        pdf.font_size 12        
        pdf.text_box("1. Inspector has mapped the damper/door", :at => [8, 605], :style => :bold, :align => :justify)        
        pdf.text_box("locations on customer provided blueprints or", :at => [8, 590], :style => :bold, :align => :justify)        
        pdf.text_box("facility layout and returned customer drawings", :at => [8, 575], :style => :bold, :align => :justify)  
        pdf.font_size 10
        if @project.m_blueprints_facility == "Yes"          
          pdf.text_box("Y", :at => [375, 605])
        elsif @project.m_blueprints_facility == "No"          
          pdf.text_box("N", :at => [375, 605])
        else          
          pdf.text_box("NA", :at => [375, 605])
        end

        #acknowledge2
        pdf.font_size 12
        pdf.text_box("2. Any two-way radios, keys, badges, ladders, or any", :at => [8, 557], :style => :bold, :align => :justify)
        pdf.text_box("other facility items used during the project have been", :at => [8, 542], :style => :bold, :align => :justify)
        pdf.font_size 10
        if @project.m_facility_items == "Yes"
          pdf.text_box("Y", :at => [375, 557])
        elsif  @project.m_facility_items == "No"
          pdf.text_box("N", :at => [375, 557])
        else
          pdf.text_box("NA", :at => [375, 557])
        end

        #acknowledge3
        pdf.font_size 12
        #pdf.text_box("4. Customer understands that a link will be emailed to", :at => [8, 473], :style => :bold, :align => :justify) old
        pdf.text_box("3. Customer understands that a link will be emailed to", :at => [8, 524], :style => :bold, :align => :justify) #new
        #pdf.text_box("them with access to their inspection reports on", :at => [8, 458], :style => :bold, :align => :justify) old
        pdf.text_box("them with access to their inspection reports on", :at => [8, 509], :style => :bold, :align => :justify) #new
        #pdf.text_box("their own web-based customer portal.", :at => [8, 443], :style => :bold, :align => :justify) old
        pdf.text_box("their own web-based customer portal.", :at => [8, 494], :style => :bold, :align => :justify) #new
        pdf.font_size 10
        if @project.m_emailed_reports == "Yes"
          #pdf.text_box("Y", :at => [375, 473]) old
          pdf.text_box("Y", :at => [375, 524]) #new
        elsif @project.m_emailed_reports == "No"
          #pdf.text_box("N", :at => [375, 473]) old
          pdf.text_box("N", :at => [375, 524]) #new
        else
          #pdf.text_box("NA", :at => [375, 473]) old
          pdf.text_box("NA", :at => [375, 524]) #new
        end

        #acknowledge4
        pdf.font_size 12
        #pdf.text_box("5. Technician has kept me informed on a daily basis of", :at => [8, 425], :style => :bold, :align => :justify) old
        pdf.text_box("4. Technician has kept me informed on a daily basis of", :at => [8, 476], :style => :bold, :align => :justify) #new
        #pdf.text_box("the project status and has made me aware of any and", :at => [8, 410], :style => :bold, :align => :justify) old
        pdf.text_box("the project status and has made me aware of any and", :at => [8, 461], :style => :bold, :align => :justify) #new
        #pdf.text_box("all situations requiring my attention.", :at => [8, 395], :style => :bold, :align => :justify) old
        pdf.text_box("all situations requiring my attention.", :at => [8, 446], :style => :bold, :align => :justify) #new
        pdf.font_size 10
        if @project.m_daily_basis == "Yes"
          #pdf.text_box("Y", :at => [375, 425]) old
          pdf.text_box("Y", :at => [375, 476]) #new
        elsif @project.m_daily_basis == "No"
          #pdf.text_box("N", :at => [375, 425]) old
          pdf.text_box("N", :at => [375, 476]) #new
        else
          #pdf.text_box("NA", :at => [375, 425]) old
          pdf.text_box("NA", :at => [375, 476]) #new
        end

        #acknowledge5
        pdf.font_size 12
        #pdf.text_box("6. Containment Tent Used?", :at => [8, 377], :style => :bold) old
        #pdf.text_box("5. Containment Tent Used?", :at => [8, 428], :style => :bold) #new #06-09-2018: Changed as per the client requirement of LP-275
        pdf.text_box("5. # of days containment tent used", :at => [8, 428], :style => :bold)
        
        pdf.font_size 10

        pdf.text_box("#{@project.m_containment_tent_used}", :at => [375, 428]) #06-09-2018: Changed as per the client requirement of LP-275


        # if @project.m_containment_tent_used == "Yes"
        #   #pdf.text_box("Y", :at => [375, 377]) old
        #   pdf.text_box("Y", :at => [375, 428]) #new
        # elsif @project.m_containment_tent_used == "No"
        #   #pdf.text_box("N", :at => [375, 377]) old
        #   pdf.text_box("N", :at => [375, 428]) #new
        # else
        #   #pdf.text_box("NA", :at => [375, 377]) old
        #   pdf.text_box("NA", :at => [375, 428]) #new
        # end

        #acknowledgeDate
        pdf.font_size 12
        #pdf.text_box("Date", :at => [8, 357], :style => :bold) old
        pdf.text_box("Date", :at => [8, 408], :style => :bold) #new
        pdf.font_size 10
        #pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [375, 357]) old
        pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [375, 408]) #new

        #acknowledgeTech_name
        pdf.font_size 12
        #pdf.text_box("Name", :at => [8, 337], :style => :bold) old
        pdf.text_box("Technician Name", :at => [8, 388], :style => :bold) #new
        pdf.font_size 10
        #pdf.text_box("#{@project.m_technician_name}", :at => [375, 337]) old
        pdf.text_box("#{@project.m_technician_name}", :at => [375, 388]) #new

        #acknowledgeCustomer_name
        pdf.font_size 12
        #pdf.text_box("Name", :at => [8, 337], :style => :bold) old
        pdf.text_box("Contact Name", :at => [8, 368], :style => :bold) #new
        pdf.font_size 10
        #pdf.text_box("#{@project.m_technician_name}", :at => [375, 337]) old
        pdf.text_box("#{@project.m_customer_name}", :at => [375, 368]) #new

        #acknowledgeSignature
        pdf.font_size 12
        #pdf.text_box("Signature", :at => [8, 287], :style => :bold) old
        pdf.text_box("Contact Signature", :at => [8, 318], :style => :bold) #new
        image = @project.m_authorization_signature.path
        unless image.blank?
          #pdf.image(image, at: [375, 317], :width => 150, :height => 70) old
          #pdf.image(image, at: [375, 335], :width => 150, :height => 70) #new
          pdf.image(image, at: [375, 348], :width => 150, :height => 60) #new
        else
        end   

      else
        #acknowledge1
        pdf.font_size 12
        #pdf.text_box("3. Any two-way radios, keys, badges, ladders, or any", :at => [8, 506], :style => :bold, :align => :justify) old
        pdf.text_box("1. Any two-way radios, keys, badges, ladders, or any", :at => [8, 605], :style => :bold, :align => :justify) #new
        #pdf.text_box("other facility items used during the project have been", :at => [8, 491], :style => :bold, :align => :justify) 
        pdf.text_box("other facility items used during the project have been", :at => [8, 590], :style => :bold, :align => :justify) #new
        pdf.font_size 10
        if @project.m_facility_items == "Yes"
          #pdf.text_box("Y", :at => [375, 506]) old
          pdf.text_box("Y", :at => [375, 605]) #new
        elsif  @project.m_facility_items == "No"
          #pdf.text_box("N", :at => [375, 506]) old
          pdf.text_box("N", :at => [375, 605]) #new
        else
          #pdf.text_box("NA", :at => [375, 506]) old
          pdf.text_box("NA", :at => [375, 605]) #new
        end
        
        #acknowledge2
        pdf.font_size 12
        #pdf.text_box("4. Customer understands that a link will be emailed to", :at => [8, 473], :style => :bold, :align => :justify) old
        pdf.text_box("2. Customer understands that a link will be emailed to", :at => [8, 572], :style => :bold, :align => :justify) #new
        #pdf.text_box("them with access to their inspection reports on", :at => [8, 458], :style => :bold, :align => :justify) old
        pdf.text_box("them with access to their inspection reports on", :at => [8, 557], :style => :bold, :align => :justify) #new
        #pdf.text_box("their own web-based customer portal.", :at => [8, 443], :style => :bold, :align => :justify) old
        pdf.text_box("their own web-based customer portal.", :at => [8, 542], :style => :bold, :align => :justify) #new
        pdf.font_size 10
        if @project.m_emailed_reports == "Yes"
          #pdf.text_box("Y", :at => [375, 473]) old
          pdf.text_box("Y", :at => [375, 572]) #new
        elsif @project.m_emailed_reports == "No"
          #pdf.text_box("N", :at => [375, 473]) old
          pdf.text_box("N", :at => [375, 572]) #new
        else
          #pdf.text_box("NA", :at => [375, 473]) old
          pdf.text_box("NA", :at => [375, 572]) #new
        end

        #acknowledge3
        pdf.font_size 12
        #pdf.text_box("5. Technician has kept me informed on a daily basis of", :at => [8, 425], :style => :bold, :align => :justify) old
        pdf.text_box("3. Technician has kept me informed on a daily basis of", :at => [8, 524], :style => :bold, :align => :justify) #new
        #pdf.text_box("the project status and has made me aware of any and", :at => [8, 410], :style => :bold, :align => :justify) old
        pdf.text_box("the project status and has made me aware of any and", :at => [8, 509], :style => :bold, :align => :justify) #new
        #pdf.text_box("all situations requiring my attention.", :at => [8, 395], :style => :bold, :align => :justify) old
        pdf.text_box("all situations requiring my attention.", :at => [8, 494], :style => :bold, :align => :justify) #new
        pdf.font_size 10
        if @project.m_daily_basis == "Yes"
          #pdf.text_box("Y", :at => [375, 425]) old
          pdf.text_box("Y", :at => [375, 524]) #new
        elsif @project.m_daily_basis == "No"
          #pdf.text_box("N", :at => [375, 425]) old
          pdf.text_box("N", :at => [375, 524]) #new
        else
          #pdf.text_box("NA", :at => [375, 425]) old
          pdf.text_box("NA", :at => [375, 524]) #new
        end
   
        #acknowledge3
        pdf.font_size 12
        #pdf.text_box("6. Containment Tent Used?", :at => [8, 377], :style => :bold) old
        #pdf.text_box("4. Containment Tent Used?", :at => [8, 476], :style => :bold) #new #06-09-2018: Changed as per the client requirement of LP-275
        pdf.text_box("4. # of days containment tent used", :at => [8, 476], :style => :bold)

        pdf.font_size 10

        pdf.text_box("#{@project.m_containment_tent_used}", :at => [375, 476]) #06-09-2018: Changed as per the client requirement of LP-275

        # if @project.m_containment_tent_used == "Yes"
        #   #pdf.text_box("Y", :at => [375, 377]) old
        #   pdf.text_box("Y", :at => [375, 476]) #new
        # elsif @project.m_containment_tent_used == "No"
        #   #pdf.text_box("N", :at => [375, 377]) old
        #   pdf.text_box("N", :at => [375, 476]) #new
        # else
        #   #pdf.text_box("NA", :at => [375, 377]) old
        #   pdf.text_box("NA", :at => [375, 476]) #new
        # end
        
        #acknowledgeDate
        pdf.font_size 12
        #pdf.text_box("Date", :at => [8, 357], :style => :bold) old
        pdf.text_box("Date", :at => [8, 456], :style => :bold) #new
        pdf.font_size 10
        #pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [375, 357]) old
        pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [375, 456]) #new        

        #acknowledgeTech_name
        pdf.font_size 12
        #pdf.text_box("Name", :at => [8, 337], :style => :bold) old
        pdf.text_box("Technician Name", :at => [8, 436], :style => :bold) #new
        pdf.font_size 10
        #pdf.text_box("#{@project.m_technician_name}", :at => [375, 337]) old
        pdf.text_box("#{@project.m_technician_name}", :at => [375, 436]) #new

        #acknowledgeCustomer_name
        pdf.font_size 12
        #pdf.text_box("Name", :at => [8, 337], :style => :bold) old
        pdf.text_box("Contact Name", :at => [8, 416], :style => :bold) #new426
        pdf.font_size 10
        #pdf.text_box("#{@project.m_technician_name}", :at => [375, 337]) old
        pdf.text_box("#{@project.m_customer_name}", :at => [375, 416]) #new

        #acknowledgeTech_name
        pdf.font_size 12
        #pdf.text_box("Signature", :at => [8, 287], :style => :bold) old
        pdf.text_box("Contact Signature", :at => [8, 366], :style => :bold) #new
        image = @project.m_authorization_signature.path
        unless image.blank?
          #pdf.image(image, at: [375, 317], :width => 150, :height => 70) old
          #pdf.image(image, at: [375, 335], :width => 150, :height => 70) #new
          pdf.image(image, at: [375, 396], :width => 150, :height => 60) #new
        else
        end
      end  
    end

    # def draw_acknowledge_blueprints(pdf)
    #   pdf.font_size 12
    #   #pdf.text_box("1. Inspector has mapped the damper/door", :at => [8, 587], :style => :bold, :align => :justify) old
    #   pdf.text_box("1. Inspector has mapped the damper/door", :at => [8, 605], :style => :bold, :align => :justify) #new
    #   #pdf.text_box("locations on customer provided blueprints or", :at => [8, 572], :style => :bold, :align => :justify) old
    #   pdf.text_box("locations on customer provided blueprints or", :at => [8, 590], :style => :bold, :align => :justify) #new
    #   #pdf.text_box("facility layout and returned customer drawings", :at => [8, 557], :style => :bold, :align => :justify) old
    #   pdf.text_box("facility layout and returned customer drawings", :at => [8, 575], :style => :bold, :align => :justify) #new
  
    #   pdf.font_size 10
    #   if @project.m_blueprints_facility == "Yes"
    #     #pdf.text_box("Y", :at => [375, 587]) old
    #     pdf.text_box("Y", :at => [375, 605]) #new

    #   elsif @project.m_blueprints_facility == "No"
    #     #pdf.text_box("N", :at => [375, 587]) old
    #     pdf.text_box("N", :at => [375, 605]) #new
    #   else
    #     #pdf.text_box("NA", :at => [375, 587]) old
    #     pdf.text_box("NA", :at => [375, 605]) #new
    #   end
    # end

    # def draw_acknowledge_replacement_checklist(pdf)
    #   pdf.font_size 12
    #   #pdf.text_box("2. Damper actutor replacement checklist provided", :at => [8, 539], :style => :bold, :align => :justify) old
    #   pdf.text_box("2. Damper actutor replacement checklist provided", :at => [8, 557], :style => :bold, :align => :justify) #new
    #   #pdf.text_box("(if replacement performed)", :at => [8, 524], :style => :bold, :align => :justify) old
    #   pdf.text_box("(if replacement performed)", :at => [8, 542], :style => :bold, :align => :justify) #new
    #   pdf.font_size 10
    #   if @project.m_replacement_checklist == "Yes"
    #     #pdf.text_box("Y", :at => [375, 539]) old
    #     pdf.text_box("Y", :at => [375, 557]) #new
    #   elsif @project.m_replacement_checklist == "No"
    #     #pdf.text_box("N", :at => [375, 539]) old
    #     pdf.text_box("N", :at => [375, 557]) #new
    #   else
    #     #pdf.text_box("NA", :at => [375, 539]) old
    #     pdf.text_box("NA", :at => [375, 557]) #new
    #   end
    # end

    # def draw_acknowledge_facility_items(pdf)
    #   pdf.font_size 12
    #   #pdf.text_box("3. Any two-way radios, keys, badges, ladders, or any", :at => [8, 506], :style => :bold, :align => :justify) old
    #   pdf.text_box("3. Any two-way radios, keys, badges, ladders, or any", :at => [8, 524], :style => :bold, :align => :justify) #new
    #   #pdf.text_box("other facility items used during the project have been", :at => [8, 491], :style => :bold, :align => :justify) 
    #   pdf.text_box("other facility items used during the project have been", :at => [8, 509], :style => :bold, :align => :justify) #new
    #   pdf.font_size 10
    #   if @project.m_facility_items == "Yes"
    #     #pdf.text_box("Y", :at => [375, 506]) old
    #     pdf.text_box("Y", :at => [375, 524]) #new
    #   elsif  @project.m_facility_items == "No"
    #     #pdf.text_box("N", :at => [375, 506]) old
    #     pdf.text_box("N", :at => [375, 524]) #new
    #   else
    #     #pdf.text_box("NA", :at => [375, 506]) old
    #     pdf.text_box("NA", :at => [375, 524]) #new
    #   end
    # end

    # def draw_acknowledge_emailed_reports(pdf)
    #   pdf.font_size 12
    #   #pdf.text_box("4. Customer understands that a link will be emailed to", :at => [8, 473], :style => :bold, :align => :justify) old
    #   pdf.text_box("4. Customer understands that a link will be emailed to", :at => [8, 491], :style => :bold, :align => :justify) #new
    #   #pdf.text_box("them with access to their inspection reports on", :at => [8, 458], :style => :bold, :align => :justify) old
    #   pdf.text_box("them with access to their inspection reports on", :at => [8, 476], :style => :bold, :align => :justify) #new
    #   #pdf.text_box("their own web-based customer portal.", :at => [8, 443], :style => :bold, :align => :justify) old
    #   pdf.text_box("their own web-based customer portal.", :at => [8, 461], :style => :bold, :align => :justify) #new
    #   pdf.font_size 10
    #   if @project.m_emailed_reports == "Yes"
    #     #pdf.text_box("Y", :at => [375, 473]) old
    #     pdf.text_box("Y", :at => [375, 491]) #new
    #   elsif @project.m_emailed_reports == "No"
    #     #pdf.text_box("N", :at => [375, 473]) old
    #     pdf.text_box("N", :at => [375, 491]) #new
    #   else
    #     #pdf.text_box("NA", :at => [375, 473]) old
    #     pdf.text_box("NA", :at => [375, 491]) #new
    #   end  
    # end

    # def draw_acknowledge_daily_basis(pdf)
    #   pdf.font_size 12
    #   #pdf.text_box("5. Technician has kept me informed on a daily basis of", :at => [8, 425], :style => :bold, :align => :justify) old
    #   pdf.text_box("5. Technician has kept me informed on a daily basis of", :at => [8, 443], :style => :bold, :align => :justify) #new
    #   #pdf.text_box("the project status and has made me aware of any and", :at => [8, 410], :style => :bold, :align => :justify) old
    #   pdf.text_box("the project status and has made me aware of any and", :at => [8, 428], :style => :bold, :align => :justify) #new
    #   #pdf.text_box("all situations requiring my attention.", :at => [8, 395], :style => :bold, :align => :justify) old
    #   pdf.text_box("all situations requiring my attention.", :at => [8, 413], :style => :bold, :align => :justify) #new
    #   pdf.font_size 10
    #   if @project.m_daily_basis == "Yes"
    #     #pdf.text_box("Y", :at => [375, 425]) old
    #     pdf.text_box("Y", :at => [375, 443]) #new
    #   elsif @project.m_daily_basis == "No"
    #     #pdf.text_box("N", :at => [375, 425]) old
    #     pdf.text_box("N", :at => [375, 443]) #new
    #   else
    #     #pdf.text_box("NA", :at => [375, 425]) old
    #     pdf.text_box("NA", :at => [375, 443]) #new
    #   end  
    # end

    # def draw_acknowledge_containment_tent_used(pdf)
    #   pdf.font_size 12
    #   #pdf.text_box("6. Containment Tent Used?", :at => [8, 377], :style => :bold) old
    #   pdf.text_box("6. Containment Tent Used?", :at => [8, 395], :style => :bold) #new
    #   pdf.font_size 10
    #   if @project.m_containment_tent_used == "Yes"
    #     #pdf.text_box("Y", :at => [375, 377]) old
    #     pdf.text_box("Y", :at => [375, 395]) #new
    #   elsif @project.m_containment_tent_used == "No"
    #     #pdf.text_box("N", :at => [375, 377]) old
    #     pdf.text_box("N", :at => [375, 395]) #new
    #   else
    #     #pdf.text_box("NA", :at => [375, 377]) old
    #     pdf.text_box("NA", :at => [375, 395]) #new
    #   end
    # end

    # def draw_acknowledge_date(pdf)
    #   pdf.font_size 12
    #   #pdf.text_box("Date", :at => [8, 357], :style => :bold) old
    #   pdf.text_box("Date", :at => [8, 375], :style => :bold) #new
    #   pdf.font_size 10
    #   #pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [375, 357]) old
    #   pdf.text_box("#{@project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [375, 375]) #new
    # end

    # def draw_acknowledge_tech_name(pdf)
    #   pdf.font_size 12
    #   #pdf.text_box("Name", :at => [8, 337], :style => :bold) old
    #   pdf.text_box("Name", :at => [8, 355], :style => :bold) #new
    #   pdf.font_size 10
    #   #pdf.text_box("#{@project.m_technician_name}", :at => [375, 337]) old
    #   pdf.text_box("#{@project.m_technician_name}", :at => [375, 355]) #new
    # end

    # def draw_acknowledge_signature(pdf)
    #   pdf.font_size 12
    #   #pdf.text_box("Signature", :at => [8, 287], :style => :bold) old
    #   pdf.text_box("Signature", :at => [8, 305], :style => :bold) #new
    #   image = @project.m_authorization_signature.path
    #   unless image.blank?
    #     #pdf.image(image, at: [375, 317], :width => 150, :height => 70) old
    #     #pdf.image(image, at: [375, 335], :width => 150, :height => 70) #new
    #     pdf.image(image, at: [375, 335], :width => 150, :height => 60) #new
    #   else
    #   end
    # end

    def projectcompletion_template
      'three_hundred_dpi/projectcomplettion_template.jpg'
    end
  end
end