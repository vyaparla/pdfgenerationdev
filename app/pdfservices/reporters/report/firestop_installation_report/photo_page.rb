module FirestopInstallationReport
  class PhotoPage
    include Report::PhotoPageWritable

    def initialize(record, group_name, facility_name, with_picture)
      @record = record
      @group_name = group_name
      @facility_name = facility_name
      @with_picture = with_picture
    end
    
    # def write(pdf)
    #   super
    #   pdf.indent(250) do
    #     draw_location_description(pdf)
    #     draw_penetration_number(pdf)
    #     draw_floor(pdf)
    #     pdf.move_down 10
    #     pdf.font_size 15
    #     draw_issue(pdf)
    #     pdf.move_down 10
    #     #pdf.text("<b>Issue : #{@record.u_issue_type}</b>", inline_format: true)
    #     if @record.u_service_type == "Fixed On Site"
    #       pdf.text("<b>Corrected with UL system : </b> #{@record.u_corrected_url_system}", inline_format: true)
    #       pdf.text("<b>Suggested UL System : </b> #{@record.u_suggested_ul_system}</b>", inline_format: true)
    #     end
    #     pdf.move_down 5
    #     pdf.text("<b>Barrier type : </b> #{@record.u_barrier_type}", inline_format: true)
    #   end
    #   pdf.fill_color '202020'
    #   #pdf.font_size 12
    #   if @record.u_service_type != "Fixed On Site"
    #     draw_before_image(pdf)
    #   else
    #     draw_before_image(pdf)
    #     draw_after_image(pdf)
    #   end
    # end

    def write(pdf)
      super

      

      # pdf.indent(250) do
      #   draw_date(pdf)
      #   draw_assets(pdf)
      #   draw_floor(pdf)
      #   draw_location_description(pdf)
      #   draw_issue(pdf)
      #   draw_barrier_type(pdf)
      #   draw_penetration_type(pdf)
      #   if @record.u_service_type == "Fixed On Site"
      #     draw_corrective_action(pdf)
      #   else
      #     draw_suggested_corrective_action(pdf)
      #   end
      # end

      draw_table1(pdf) 
      draw_table2(pdf) 
      pdf.move_down 20

      if @with_picture
        if @record.u_service_type != "Fixed On Site"
          draw_before_image(pdf) 
        else
          draw_before_image(pdf)
          draw_after_image(pdf)
        end
      end
    end

  private
    def table_params
      contracted_by = @group_name.blank? ? @facility_name : @group_name
      floor = @record.u_floor == "other" ? @record.u_other_floor : @record.u_floor

      { contracted_by: contracted_by ,
        facility: @facility_name,
        building: @record.u_building,
        installation_date: @record.work_dates,
        installed_by: @record.u_inspector,
        floor: floor,
        location: @record.u_location_desc,
        technician: @record.u_inspector,
        dept_area: @record.u_department_str_firestopinstall
      }
        
    end

    def draw_table1(pdf)
      if @record.u_service_type&.upcase == 'FIXED ON SITE'
        status_content = "<font size='8' color='FFFFFF'><b>FIXED ONSITE</b></font>"
        cell_color = '13db13'
      else
        status_content = "<font size='8' color='FFFFFF'><b>NOT FIXED ONSITE</b></font>"
        cell_color = 'ef3038'
      end

      pdf.table([
        [
          {:content => "<font size='12'><b>#{title.upcase}</b></font>", :colspan => 500, align: :center },
          {:content => "Status:", :colspan => 100, align: :left },
          {:content => status_content, :background_color=> cell_color,:colspan => 300, align: :center },
          {:content => "Issue #<br/><b>#{@record.u_tag}</b>", :colspan => 300, 
            :rowspan => 2, align: :right }
        ],
        [  
          { :content => "<font size='12'>Facility:  #{table_params[:facility]}</font>",
            :colspan => 500, align: :left },
          { :content => "<font size='12'>Floor:  #{table_params[:floor]}</font>", 
            :colspan => 400, align: :left }
        ],
        [
          { :content => "<font size='12'>Building:  #{table_params[:building]}</font>", 
            :colspan => 500, :align => :left, :padding => [0, 0, 20, 10] },
          { :content => "<font size='12'>Issue Location:  #{table_params[:location]}</font>", 
            :colspan => 700, align: :left }          
        ],
        [
          { :content => "<font size='12'>Dept/Area:  #{table_params[:dept_area]}</font>", 
            :colspan => 500, align: :left },
          { :content => "", :colspan => 700 }          
        ],
        [
          { :content => "<font size='12'>Date:</font>", 
            :colspan => 200, align: :right },
          { :content => "<font size='12'>#{@record.u_inspected_on.localtime.strftime('%m/%d/%Y')}</font>", 
            :colspan => 100, align: :left }, 
          { :content => "<font size='12'>Time:</font>", 
            :colspan => 200, align: :right },
          { :content => "<font size='12'>#{@record.u_inspected_on.localtime.strftime('%I:%M:%S %P')}</font>", 
            :colspan => 100, align: :left },
          { :content => "<font size='12'>LSS Technician</font>", 
            :colspan => 300, align: :left },
          { :content => "<font size='12'>#{table_params[:technician]}</font>", 
            :colspan => 300, align: :center }             
        ]  
      ], :cell_style => { :inline_format => true })
      pdf.move_down 20
    end 

    def draw_table2(pdf)
       pdf.table([
        [
          {:content => "<font size='12'><b>ISSUE</b></font>",  :colspan => 800, :align => :center },
          {:content => "<font size='12'><b>BARRIER TYPE</b></font>", :colspan => 800, :align => :center},
          {:content => "<font size='12'><b>PENETRATION TYPE</b></font>", :colspan => 800, :align => :center}
        ],
        [  
          {:content => "<font size='10'>#{@record.u_issue_type}</font>", :colspan => 800, :align => :left },
          {:content => "<font size='10'>#{@record.u_barrier_type}</font>", :colspan => 800, :align => :left },
          {:content => "<font size='10'>#{@record.u_penetration_type}</font>", 
           :colspan => 800, :align => :left }
        ],
        [
          {:content => "<font size='12'><b>CORRECTIVE ACTION / UL SYSTEM</b></font>", 
            :colspan => 800, :align => :center  },
          {:content => "<font size='12'><b>COMMENT</b></font>", 
            :colspan => 1600, :align => :center }          
        ],
        [
          {:content => "<font size='12'>#{@record.u_corrected_url_system}</font>",
           :colspan => 800, :align => :left, :overflow => :shrink_to_fit, :min_font_size => 8,
            :height => 20 },
          {:content => "<font size='12'></font>", :colspan => 1600, :align => :left, 
            :overflow => :shrink_to_fit, :min_font_size => 8,
            :height => 20 },
        ]  
      ], :cell_style => { :inline_format => true })
      pdf.move_down 20
    end 

    def draw_title(pdf)
      pdf.font_size 12
      pdf.text("<b>FIRESTOP INSTALLATION REPORT</b>", inline_format: true)
    end
      
    def draw_date(pdf)
      pdf.font_size 12
      pdf.text("<b>Date :</b> #{@record.u_inspected_on.localtime.strftime('%m/%d/%Y')}", inline_format: true)
      pdf.move_down 10
    end

    def draw_assets(pdf)
      pdf.font_size 12
      pdf.text("<b>Asset # :</b> #{@record.u_tag}", inline_format: true)
      pdf.move_down 10
    end

    def draw_floor(pdf)
      if @record.u_floor == "other"
        pdf.font_size 12
        pdf.text("<b>Floor :</b> #{@record.u_other_floor}", inline_format: true)
        pdf.move_down 10
      else
        pdf.font_size 12
        pdf.text("<b>Floor :</b> #{@record.u_floor}", inline_format: true)
        pdf.move_down 10
      end
    end

    def draw_location_description(pdf)
      pdf.font_size 12
      pdf.text("<b>Location :</b> #{@record.u_location_desc}", inline_format: true)
      pdf.move_down 10
    end

    def draw_issue(pdf)
      pdf.font_size 12
      pdf.text("<b>Issue :</b> #{@record.u_issue_type}", inline_format: true)
      pdf.move_down 10
    end

    def draw_barrier_type(pdf)
      pdf.font_size 12
      pdf.text("<b>Barrier Type :</b> #{@record.u_barrier_type}", inline_format: true)
      pdf.move_down 10
    end

    def draw_penetration_type(pdf)
      pdf.font_size 12
      pdf.text("<b>Penetration Type :</b> #{@record.u_penetration_type}", inline_format: true)
      pdf.move_down 10
    end

    def draw_corrective_action(pdf)
      pdf.font_size 12
      pdf.text("<b>Corrective Action :</b> #{@record.u_corrected_url_system}", inline_format: true)
      pdf.move_down 10
    end
    
    def draw_suggested_corrective_action(pdf)
      pdf.font_size 12
      pdf.text("<b>Suggested Corrective Action :</b> #{@record.u_suggested_ul_system}", inline_format: true)
      pdf.move_down 10
    end

    # def draw_penetration_number(pdf)
    #   pdf.font_size 15
    #   pdf.text("<b>Asset # :</b> #{@record.u_tag}", inline_format: true)
    #   #pdf.text("<b>Penetration Number :</b> #{@record.u_tag}", inline_format: true)
    # end

    def draw_before_image(pdf)
      image = @record.pdf_image1.path(:pdf)      
      unless image.blank?
        pdf.image(image, at: [60 - pdf.bounds.absolute_left, 300], fit: [225, 225])#521
      else
        pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", 
          at: [60 - pdf.bounds.absolute_left, 300])
        pdf.draw_text('Photo Unavailable', style: :bold, size:  12,  at: [100 - pdf.bounds.absolute_left, 300])#404
      end
      pdf.draw_text("Issue", at: [120 - pdf.bounds.absolute_left, 15])#280
    end

    def draw_after_image(pdf)
      image = @record.pdf_image2.path(:pdf)      
      unless image.blank?
        pdf.image(image, at: [330 - pdf.bounds.absolute_left, 300], fit: [225, 225])
      else
        pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", at: [330 - pdf.bounds.absolute_left, 300])
        pdf.draw_text('Photo Unavailable', style: :bold, size:  12, at: [400 - pdf.bounds.absolute_left, 300])
      end
      pdf.draw_text("Corrected Issue", at: [410 - pdf.bounds.absolute_left, 15])      
    end

    def title
      'Firestop Installation Report'
    end

    # def splitBase64(uri)
    #   if uri.match(%r{^data:(.*?);(.*?),(.*)$})
    #     return {
    #       type:      $1, # "image/png"
    #       encoder:   $2, # "base64"
    #       data:      $3, # data string
    #       extension: $1.split('/')[1] # "png"
    #     }
    #   end
    # end
  end
end