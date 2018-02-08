module FirestopInstallationReport
  class TablePage
  	include Report::DataPageWritable

    def initialize(job, building, tech)
      @job = job
      @building = building
      @tech = tech
    end

    def write(pdf)
      return if records.empty?
      super
      @fixed_on_site = []
      fixed_on_site_heading = [{:content => 'Fixed On Site = YES', :colspan => 540}]
      @fixed_on_site << fixed_on_site_heading
      fixed_on_site = ['Date', 'Asset #', 'Floor', 'Location', 'Issue', "Barrier Type", 'Penetration Type', "Corrective Action"]
      @fixed_on_site << fixed_on_site

      @survey_only = []
      survey_only_heading = [{:content => 'Fixed On Site = NO', :colspan => 540}]
      @survey_only << survey_only_heading
      survey_only  = ['Date', 'Asset #', 'Floor', 'Location', 'Issue', "Barrier Type", 'Penetration Type', "Suggested Corrective Action"]
      @survey_only << survey_only
   
      records.each do |record|
        if record.u_service_type == "Fixed On Site"
          @fixed_on_site << [record.u_inspected_on.localtime.strftime('%m/%d/%Y'), record.u_tag, record.u_floor.to_i, record.u_location_desc,
                            record.u_issue_type, record.u_barrier_type, record.u_penetration_type, record.u_corrected_url_system]
        else
          @survey_only << [record.u_inspected_on.localtime.strftime('%m/%d/%Y'), record.u_tag, record.u_floor.to_i, record.u_location_desc,
                           record.u_issue_type, record.u_barrier_type, record.u_penetration_type, record.u_suggested_ul_system]
        end
      end
      draw_fixed_on_site(pdf)
      draw_survey_only(pdf)      
    end
 
  private

    def draw_fixed_on_site(pdf)
      #pdf.table([["Fixed On Site = YES"]], :cell_style => {:border_color => "888888", }, :width => 540)
      pdf.table(@fixed_on_site, :column_widths => { 0 => 55 }, header: true, cell_style: { align: :center, size: 8 }) do |table|
        table.row_colors = ['ffffff', 'eaeaea']
        table.rows(0).style { |r| r.border_color = '888888' }
        table.rows(1..(table.row_length - 1)).style do |r|
          r.border_color = 'cccccc'
        end
        table.row(0).style text_color: '444444', size: 10, font_style: :bold
        table.row(1).style background_color: '444444', text_color: 'ffffff'
        table.column(1).style { |c| c.width = 60 } # Asset#
        table.column(2).style { |c| c.width = 40 } # Floor
        table.column(3).style { |c| c.width = 70 } # Location
        table.column(4).style { |c| c.width = 65 } # Issue
        table.column(5).style { |c| c.width = 75 } # Barrier Type
        table.column(6).style { |c| c.width = 75 } # Penetration Type
        table.column(7).style { |c| c.width = 100 } # Corrective Action

        # table.column(1).style { |c| c.width = 60 } # Asset #
        # table.column(2).style { |c| c.width = 40 } # Floor
        # table.column(3).style { |c| c.width = 70 } # Location
        # table.column(4).style { |c| c.width = 55 } # Barrier Type
        # table.column(5).style { |c| c.width = 55 } # Penetration Type
        # table.column(6).style { |c| c.width = 60 } # Issue
        # table.column(7).style { |c| c.width = 60 } # Corrected On Site
        # table.column(8).style { |c| c.width = 80 } # Corrected with UL System
      end
      pdf.move_down 20
    end

    def draw_survey_only(pdf)      
      #pdf.table([["Fixed On Site = NO"]], :cell_style => {:border_color => "888888"}, :width => 540)
      pdf.table(@survey_only, :column_widths => { 0 => 55 }, header: true, cell_style: { align: :center, size: 8 }) do |table|
        table.row_colors = ['ffffff', 'eaeaea']
        table.rows(0).style { |r| r.border_color = '888888' }
        table.rows(1..(table.row_length - 1)).style do |r|
          r.border_color = 'cccccc'
        end
        table.row(0).style text_color: '444444', size: 10, font_style: :bold
        table.row(1).style background_color: '444444', text_color: 'ffffff'
        table.column(1).style { |c| c.width = 60 } # Asset#
        table.column(2).style { |c| c.width = 40 } # Floor
        table.column(3).style { |c| c.width = 70 } # Location
        table.column(4).style { |c| c.width = 65 } # Issue
        table.column(5).style { |c| c.width = 75 } # Barrier Type
        table.column(6).style { |c| c.width = 75 } # Penetration Type
        table.column(7).style { |c| c.width = 100 } # Suggested Corrective Action
        # table.column(1).style { |c| c.width = 60 } # Asset #
        # table.column(2).style { |c| c.width = 40 } # Floor
        # table.column(3).style { |c| c.width = 70 } # Location
        # table.column(4).style { |c| c.width = 55 } # Barrier Type
        # table.column(5).style { |c| c.width = 55 } # Penetration Type
        # table.column(6).style { |c| c.width = 60 } # Issue
        # table.column(7).style { |c| c.width = 60 } # Corrected On Site
        # table.column(8).style { |c| c.width = 80 } # Corrected with UL System
      end
    end 

    def building
      @building
    end

    def records
      @records ||= @job.building_records(@building, @job.u_service_id)
    end

    def date_key
      :installation_date
    end

    def technician_key
      :installed_by
    end
  end
end