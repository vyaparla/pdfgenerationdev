module DamperInspectionReport
  class PhotoPage
    require "resolv"
    include Report::PhotoPageWritable

#    def initialize(record, options = {}, group_name, facility_name)
#      @record = record
#      #Rails.logger.debug("Photo Records :#{@record.inspect}")
#      @options = options
#      @group_name = group_name
#      @facility_name = facility_name
#    end


    def initialize(record, group_name, facility_name, with_picture, watermark)
      @record = record
      @group_name = group_name
      @facility_name = facility_name
      @with_picture = with_picture
      @watermark = watermark
    end

    def write(pdf)
      if @record.u_status == "Removed"
      else	    
      super
      pdf.stamp_at "watermark", [100, 210] if @watermark 
      draw_table1(pdf)
      draw_table2(pdf)
      draw_table3(pdf)
      draw_table4(pdf)
      pdf.move_down 5

      if @with_picture
	      draw_open_image(pdf)
        draw_closed_image(pdf)
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
	    pdf.move_down 20     
	    if @record.u_status.upcase == "PASS" 
        status_content = "<font size='12'><b>Pass</b></font>"
        cell_color = '13db13'
	    elsif @record.u_status.upcase == "FAIL" || @record.u_status.upcase == "NA"
	      status_details = @record.u_status.upcase == "FAIL" ? "Fail" : "Non-Accessible"
        status_content = "<font size='12'><b>#{status_details}</b></font>"
        cell_color = 'ef3038'
      else
        status_content = "<font size='12'><b>Removed</b></font>"
        cell_color = '000000'
      end
      pdf.table([
        [
          {:content => "<font size='12'><b>DAMPER INSPECTION REPORT</b></font>", :colspan => 3, :width => 225, align: :center },
          {:content => "Status:", :colspan => 1, :width => 75, align: :left },
          {:content => status_content, :background_color=> cell_color,:colspan => 1, :width => 105,
            :align => :center, :text_color => "ffffff" },
          {:content => "Asset #<br/><b>#{@record.u_tag}</b>", :colspan => 1, :width => 135,
            :rowspan => 2, align: :right }
        ],
        [
          { :content => "<font size='12'>Facility:  #{table_params[:facility]}</font>",
            :colspan => 3, :width => 225, align: :left },
          { :content => "<font size='12'>Floor:  #{table_params[:floor]}</font>",
            :colspan => 2, :width => 180, align: :left }
        ],
        [
          { :content => "<font size='12'>Building:  #{table_params[:building]}</font>",
            :colspan => 3, :width => 225, :align => :left },
          { :content => "<font size='12'>Damper Location:  #{table_params[:location]}</font>",
            :colspan => 3, :width => 315, align: :left }
        ],
        [
          { :content => "<font size='12'>Dept/Area:  #{table_params[:dept_area]}</font>",
            :colspan => 3, :width => 225, align: :left },
          { :content => "", :colspan => 3, :width => 315 }
        ],
        [
          { :content => "<font size='12'>Date:</font>",
            :colspan => 1, :width => 60, align: :right },
          { :content => "<font size='11'>#{@record.u_inspected_on.localtime.strftime('%m/%d/%Y')}</font>",
            :colspan => 1, :width => 75, align: :left },
          { :content => "<font size='12'>Time:</font>",
            :colspan => 1, :width => 90, align: :right },
          { :content => "<font size='11'>#{@record.u_inspected_on.localtime.strftime('%I:%M:%S %p')}</font>",
            :colspan => 1, :width => 75, align: :left },
          { :content => "<font size='12'>Technician</font>",
            :colspan => 1, :width => 105, align: :left },
          { :content => "<font size='12'>#{table_params[:technician]}</font>",
            :colspan => 1, :width => 135, align: :center }
        ]
      ], :cell_style => { :inline_format => true })
      pdf.move_down 5
    end

    def draw_table2(pdf)
      if @record.u_damper_name.upcase == "FIRE"
        damper_type = 'Fire Damper (FD)'
      elsif @record.u_damper_name.upcase == "SMOKE"
        damper_type = 'Smoke Damper (SD)'
      else
        damper_type = 'Fire Smoke Damper (FSD)'
      end
      pdf.table([
        [
          { :content => "<font size='14'><b>DAMPER DESCRIPTION:</b></font>",
            :colspan => 6, :width => 515, align: :center }
        ],
        [ { :content => "<font size='12'>Damper Type:</font>",
            :colspan => 1, :width => 60, align: :center },
          { :content => "<font size='12'>#{damper_type}</font>",
            :colspan => 5, :width => 455, align: :left }
        ]
      ], :cell_style => { :inline_format => true })
      pdf.move_down 5
    end

    def draw_table3(pdf)
      deficiencies =  if @record.u_status == "Fail"
                    @record.u_reason
                  else
                    @record.u_non_accessible_reasons
                  end
      pdf.table([
        [
          { :content => "<font size='14'><b>DEFICIENCY DESCRIPTION(s):</b></font>",
            :colspan => 2, :width => 225, align: :left },
          { :content => "<font size='14'><b>COMMENT:</b></font>",
            :colspan => 4, :width => 315, align: :left }
        ],
        [
          { :content => "<font size='12'>#{deficiencies}</font>",
            :colspan => 2, :width => 225, align: :left },
          { :content => "<font size='12'>#{@record.u_dr_description}</font>",
            :colspan => 4, :width => 315, align: :left }
        ],

      ], :cell_style => { :inline_format => true })
      pdf.move_down 5
    end

    def draw_table4(pdf)
      pdf.table([
        [
          { :content => "<font size='12'><b>REPAIR ACTION(s) PERFORMED:</b></font>",
            :colspan => 2, :width => 225, align: :left },
          { :content => "<font size='12'><b>SUBSEQUENT FAILURE REASON:</b></font>",
            :colspan => 4, :width => 315, align: :left }
        ],
        [
          { :content => "<font size='12'>#{@record.u_repair_action_performed}</font>",
            :colspan => 2, :width => 225, align: :left },
          { :content => "<font size='12'>#{@record.u_reason2}</font>",
            :colspan => 4, :width => 315, align: :left }
        ],

      ], :cell_style => { :inline_format => true })
      pdf.move_down 5
    end


    def draw_location_description(pdf)
      pdf.font_size 20
      pdf.text(@record.u_location_desc, inline_format: true)
      pdf.move_down 25
    end

    def draw_damper_tag(pdf)
      pdf.font_size 15        
      pdf.text("<b>#{label(:tag_number)} : </b> #{@record.u_tag}", inline_format: true)
    end

    def draw_damper_type(pdf)
      if @record.u_damper_name.upcase == "FIRE"
        pdf.text("<b>#{label(:damper_type)} : </b> Fire Damper", inline_format: true)
      elsif @record.u_damper_name.upcase == "SMOKE"
        pdf.text("<b>#{label(:damper_type)} : </b> Smoke Damper", inline_format: true)
      else
        pdf.text("<b>#{label(:damper_type)} : </b> Combination", inline_format: true)
      end
        #pdf.text("<b>#{label(:damper_type)} : </b> #{@record.u_damper_name}", inline_format: true)
    end

    def draw_floor(pdf)
      pdf.text("<b>#{label(:floor)} : </b> #{@record.u_floor}", inline_format: true)
    end

    def draw_access_door_installation(pdf)
      if @record.u_di_installed_access_door == "true"
        pdf.text("<b>Installed Access Door : </b> YES", inline_format: true)  
      else
        pdf.text("<b>Installed Access Door : </b> NO", inline_format: true)
      end
    end
 
    def draw_status(pdf)
      pdf.move_down 10
      if @record.u_status == "Pass"
        pdf.fill_color '137d08'
      elsif @record.u_status == "Fail"
        pdf.fill_color 'c1171d'
      elsif @record.u_status == "NA"
        pdf.fill_color 'f39d27'
      else
        pdf.fill_color 'c1171d'
      end
      pdf.text("<b>#{label(:status)} : </b> #{@record.u_status}", inline_format: true)
      pdf.fill_color '202020'
    end

    def label(i18n_key)
      I18n.t("pdf.photo_page.label.#{i18n_key}")
    end
      
    def draw_failure_reasons(pdf)
      pdf.move_down 10
      pdf.fill_color 'c1171d'
      pdf.text("<b>#{DamperInspectionReporting.translate(:failure_reasons)} : </b> #{@record.u_reason}", inline_format: true)
      if @record.u_reason.delete(' ').upcase == "OTHER"
        pdf.text("<b>Other Failure Reason : </b> #{@record.u_other_failure_reason}", inline_format: true)
      end
    end      

    def draw_na_reasons(pdf)
      pdf.move_down 10
      pdf.fill_color 'f39d27'
      pdf.text("<b>Non-Accessible Reason : </b> #{@record.u_non_accessible_reasons}", inline_format: true)
      if @record.u_non_accessible_reasons.delete(' ').upcase == "OTHER"
        pdf.text("<b>Other Non-Accessible Reason  : </b> #{@record.u_other_nonaccessible_reason}", inline_format: true)
      end
    end

    def draw_passed_postrepair(pdf)
      pdf.move_down 10
      pdf.fill_color 'f39d27'
      if @record.u_di_repaired_onsite == "true"
        pdf.text("<b>Post Repair Status  : </b> #{@record.u_di_passed_post_repair}", inline_format: true)
      else
        pdf.text("<b>Post Repair Status  : </b> Not Repaired", inline_format: true)
      end
    end

    def draw_open_image(pdf)
      pdf.move_down 20
      pdf.stamp_at "watermark", [100, 210] if @watermark 
      image =  @record.pdf_image1.path(:pdf)
      unless image.blank?
        pdf.image(image, at: [50 - pdf.bounds.absolute_left, 255], :width => 220, :height => 220)#521
        pdf.draw_text("Before Inspection",  at: [100 - pdf.bounds.absolute_left, 25])
      end
      pdf.move_down 5
      
    end

    def draw_closed_image(pdf)
      pdf.stamp_at "watermark", [100, 210] if @watermark 
      unless @record.u_status == "NA"	    
       pdf.move_down 20
        image =  @record.pdf_image2.path(:pdf)
        unless image.blank?
          pdf.image(image, at: [280 - pdf.bounds.absolute_left, 255], :width => 220, :height => 220)#521
          pdf.draw_text("After Inspection",  at: [350 - pdf.bounds.absolute_left, 25])
        end
        pdf.move_down 5
        pdf.stamp_at "watermark", [100, 210] if @watermark 
     end
    end

    def draw_actuator_image(pdf)
     	top_margin_pic_offset = 235
      pdf.fill_color '202020'
      pdf.font_size 12
       pdf.stamp_at "watermark", [100, 210] if @watermark 
      if @record.u_image3
        pdf.image("#{Rails.root}/lib/pdf_generation/report_assets/picture_ds.png", at: [275 - pdf.bounds.absolute_left, 496 - top_margin_pic_offset])
      end        
      image = @record.pdf_image3.path(:pdf)
      unless image.blank?
        pdf.image(image, at: [290 - pdf.bounds.absolute_left, 481 - top_margin_pic_offset], fit: [225, 225])
      else
        pdf.draw_text('Photo Unavailable', style: :bold, size:  12, at:  [350 - pdf.bounds.absolute_left, 364 - top_margin_pic_offset])
      end   
       pdf.stamp_at "watermark", [100, 210] if @watermark        
        pdf.move_down 100
        pdf.draw_text(DamperInspectionReporting.translate(:actuator), at: [290 - pdf.bounds.absolute_left, 243 - top_margin_pic_offset])
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
    
      def comprehensive?
        @options[:comprehensive] == true
      end
      
      def draw_heading(pdf)
	      pdf.fill_color '202020'
      end

      def title
        return 'COMPREHENSIVE FIRE AND SMOKE DAMPER REPORT' if comprehensive?
        DamperInspectionReporting.translate(:heading)
      end

  end
end
