module FirestopStatementReport 
  class TablePage
    include Report::DataPageWritable

    def initialize(records, building_section, tech, watermark)
      @records = records
      @building_section = building_section
      @tech = tech
      @watermark = watermark

      @fixed_on_site = []
      @survey_only = []

      @records.each do |record|
        if record.u_floor == "other"
          @floor = record.u_other_floor
        else
          @floor = record.u_floor
        end  
        if record.u_service_type == "Fixed On Site"
		inspected_on = record.u_inspected_on.nil? ? record.u_inspected_on : record.u_inspected_on.localtime.strftime('%m/%d/%Y')
          @fixed_on_site << [inspected_on, record.u_tag, @floor, record.u_location_desc,
                             record.u_issue_type, record.u_barrier_type, record.u_penetration_type, record.u_corrected_url_system]
        else
		inspected_on = record.u_inspected_on.nil? ? record.u_inspected_on : record.u_inspected_on.localtime.strftime('%m/%d/%Y')	
		#TODO
          @survey_only << [inspected_on,
			   record.u_tag, @floor, record.u_location_desc,
                           record.u_issue_type, record.u_barrier_type, record.u_penetration_type, record.u_suggested_ul_system]
        end
      end
    end

    def write(pdf)
      if !@fixed_on_site.blank?
        if @fixed_on_site.count <= 9 && (@fixed_on_site.count >= 8 || @fixed_on_site.count == 9)
          super
          pdf.stamp_at "watermark", [100, 210] if @watermark 
          draw_fixed_on_site(pdf, @fixed_on_site)

          if !@survey_only.blank?
            @survey_only_set = @survey_only.each_slice(9).to_a
            count = 0
            @survey_only_set.count.times do
              super
              pdf.stamp_at "watermark", [100, 210] if @watermark 
              draw_survey_only(pdf, @survey_only_set[count])
              count = count +1
            end
          end
        end
        if @fixed_on_site.count > 9
          #super
          @fixed_on_site_set = @fixed_on_site.each_slice(9).to_a
          p @fixed_on_site_set.last.count
          @get_no_of_survey_data = (@fixed_on_site_set.last.count - 9).abs
          count = 0
          @fixed_on_site_set.count.times do
            super
            pdf.stamp_at "watermark", [100, 210] if @watermark 
            draw_fixed_on_site(pdf, @fixed_on_site_set[count])
            count = count + 1
          end

        end
        if @fixed_on_site.count <= 8
          @get_no_of_survey_data = 9 - @fixed_on_site.count
          super
          pdf.stamp_at "watermark", [100, 210] if @watermark 
          draw_fixed_on_site(pdf, @fixed_on_site)
        end
      end

      if !@get_no_of_survey_data.blank? && !@survey_only.blank?
        if (@get_no_of_survey_data == 0 || @get_no_of_survey_data < 4)
          super
          pdf.stamp_at "watermark", [100, 210] if @watermark 
          draw_survey_only(pdf, @survey_only.first(9))
          @new_survey_only = @survey_only.drop(9)
        else

          @first_and_drop_survey_records = @get_no_of_survey_data > 2 ? @get_no_of_survey_data - 2 : 2 - @get_no_of_survey_data

          @new_first_and_drop_survey_records = @first_and_drop_survey_records <= 9 ? 9 : @first_and_drop_survey_records
          if @new_first_and_drop_survey_records <= 8
            super
            pdf.stamp_at "watermark", [100, 210] if @watermark 
          end
          draw_survey_only(pdf, @survey_only.first(@first_and_drop_survey_records))
          @new_survey_only = @survey_only.drop(@first_and_drop_survey_records)
        end
      end

      if !@new_survey_only.blank?
        #call_survey_data(pdf, @new_survey_only)
        @survey_only_set = @new_survey_only.each_slice(9).to_a
        count = 0
        @survey_only_set.count.times do
          super
          pdf.stamp_at "watermark", [100, 210] if @watermark 
          draw_survey_only(pdf, @survey_only_set[count])
          count = count + 1
        end
      end

      if @fixed_on_site.blank? && !@survey_only.blank?
        # call_survey_data(pdf, @survey_only)
        @survey_only_set = @survey_only.each_slice(9).to_a
        count = 0
        @survey_only_set.count.times do
          super
          pdf.stamp_at "watermark", [100, 210] if @watermark 
          draw_survey_only(pdf, @survey_only_set[count])
          count = count + 1
        end
      end
    end

  private

    def draw_fixed_on_site(pdf, data)

      @content = [{:content => 'Fixed On Site = YES', :colspan => 540, align: :center}]
      @header = ['Date', 'Issue #', 'Floor', 'Location', 'Issue', "Barrier Type", 'Penetration Type', "Corrective Action"]

      pdf.table([@content]+[@header]+data, :column_widths => { 0 => 55 }, header: 2, cell_style: { size: 8 }) do |table|
        table.row_colors = ['ffffff', 'eaeaea']
        table.rows(0).style { |r| r.border_color = '888888' }
        table.rows(1).style { |r| r.height = 27 }
        table.rows(2..(table.row_length - 1)).style do |r|
          r.border_color = 'cccccc'
          r.height = 49 #40 #if r.height < 25
        end

        table.row(0).style text_color: '444444', size: 10, font_style: :bold
        table.row(1).style background_color: '444444', text_color: 'ffffff'
        table.column(0).style { |c| c.width = 50 } # Date
        table.column(1).style { |c| c.width = 50 } # Asset#
        table.column(2).style { |c| c.width = 40 } # Floor
        table.column(3).style { |c| c.width = 160 } # Location
        table.column(4).style { |c| c.width = 60 } # Issue
        table.column(5).style { |c| c.width = 60 } # Barrier Type
        table.column(6).style { |c| c.width = 60 } # Penetration Type
        table.column(7).style { |c| c.width = 60 } # Corrective Action
      end
      pdf.move_down 30
    end

    def draw_survey_only(pdf, data)
      @content = [{:content => 'Fixed On Site = NO', :colspan => 540, align: :center}]
      @header =  ['Date', 'Issue #', 'Floor', 'Location', 'Issue', "Barrier Type", 'Penetration Type', "Suggested Corrective Action"]
      main_content  =  [@content] + [@header] + data
      pdf.table(main_content, :column_widths => { 0 => 55 }, header: 2, cell_style: { size: 8 }) do |table|
        table.row_colors = ['ffffff', 'eaeaea']
        table.rows(0).style { |r| r.border_color = '888888' }
        table.rows(1).style { |r| r.height = 27 }
        table.rows(2..(table.row_length - 1)).style do |r|
          r.border_color = 'cccccc'
          r.height =  49 #40
        end
        table.row(0).style text_color: '444444', size: 10, font_style: :bold
        table.row(1).style background_color: '444444', text_color: 'ffffff'
        table.column(0).style { |c| c.width = 50 } # Date
        table.column(1).style { |c| c.width = 50 } # Asset#
        table.column(2).style { |c| c.width = 40 } # Floor
        table.column(3).style { |c| c.width = 160 } # Location
        table.column(4).style { |c| c.width = 60 } # Issue
        table.column(5).style { |c| c.width = 60 } # Barrier Type
        table.column(6).style { |c| c.width = 60 } # Penetration Type
        table.column(7).style { |c| c.width = 60 } # Suggested Corrective Action
      end
    end

    def owner
      @job ||= @records.last
    end

    def building
      @building ||= @building_section
    end

     def date_key
      :survey_date
    end

    def technician_key
      :surveyed_by
    end

    def technician
      @tech
    end

  end
end
