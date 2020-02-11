module FirestopStatementReport 
  class SummaryPage
    include  Report::DataPageWritable

    def initialize(job, tech)
      @job = job
      @tech = tech
    end
  
    def write(pdf)
      super
      draw_project_summary(pdf)
      draw_statistics(pdf)
      draw_overview_of_issues(pdf)
      draw_issues_by_category(pdf)
    end

  private
  
    def draw_project_summary(pdf)
      pdf.font "Helvetica"
      pdf.font_size 30
      pdf.fill_color 'ED1C24'
      pdf.text("Project Summary", :align => :center, :style => :bold)
    end

    def draw_statistics(pdf)
      pdf.move_down 10
      pdf.font "Helvetica"
      pdf.font_size 20
      pdf.fill_color 'ED1C24'
      pdf.text("Statistics", :align => :center, :style => :bold)
    end

    def draw_overview_of_issues(pdf)      
      pdf.fill_color '202020'
      pdf.move_down 12
      pdf.font_size 10
      get_ids = @job.uniq_records(@job.u_facility_id)
      
      @total_issue = Lsspdfasset.select(:u_issue_type).where(:id => get_ids).collect(&:u_issue_type).count
      @issue_types = Lsspdfasset.select(:u_issue_type, :u_service_type).where(:id => get_ids).group(["u_service_type"]).count(:u_service_type)
      @issue_fixed_on_site = 0
      @issue_survey_only = 0
      @issue_types = Lsspdfasset.select(:u_issue_type, :u_service_type).where(:id => get_ids).group(["u_service_type"]).count(:u_service_type)      
      @issue_types.each do |key, value|
        if key == "Fixed On Site"
          @issue_fixed_on_site = value
        else
          @issue_survey_only = value
        end
      end

      overview = [["Overview of Issues", "Count", " %"]] + 
                 [["Total:", @total_issue, "#{((@total_issue * 100) / @total_issue).round(2)}%"],
                   ["Fixed During Survey:", @issue_fixed_on_site, "#{((@issue_fixed_on_site.to_f * 100 ) / @total_issue).round(2)}%"],
                   ["Open Issues to Resolve:", @issue_survey_only, "#{((@issue_survey_only.to_f * 100 ) / @total_issue).round(2)}%"]
                 ]

      pdf.font_size 10
      pdf.table(overview, header: true) do |table|
        table.row_colors = ['ffffff', 'eaeaea']
        table.rows(0).style {|r| r.border_color = '888888'}
        table.rows(1..(table.row_length-1)).style do |r|
          r.border_color = 'cccccc'
        end
        table.row(0).style background_color: '444444', text_color: 'ffffff'
        table.column(1).style {|c| c.align = :center }
        table.column(2).style {|c| c.align = :center }
      end
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


    def draw_issues_by_category(pdf)
     # pdf.bounding_box([325, 414], :width => 250, :height => 220) do
      pdf.bounding_box([325, 414], :width => 230, :height => 420) do	      
        pdf.fill_color '202020'      
        pdf.font_size 10
        survey_issue_summary = []
        survey_issue_summary << ["Issues by Category", "Count", "%"]
	get_ids = @job.uniq_records(@job.u_facility_id)
        @firestop_survey_summary = Lsspdfasset.select(:u_issue_type).where(:id => get_ids).group(["u_issue_type"]).count(:u_issue_type)
        @firestop_survey_issue_count = 0
        @firestop_survey_summary.each do |key, value|
          @firestop_survey_issue_count += value        
        end
      
        @firestop_survey_summary.each do |key, value|
          survey_issue_summary << [key, value, "#{((value.to_f * 100 ) / @firestop_survey_issue_count).round(3)}%"]
        end
      
        pdf.font_size 10
        pdf.table(survey_issue_summary, header: true) do |table|
          table.row_colors = ['ffffff', 'eaeaea']
          table.rows(0).style {|r| r.border_color = '888888'}
          table.rows(1..(table.row_length-1)).style do |r|
            r.border_color = 'cccccc'
          end
          table.row(0).style background_color: '444444', text_color: 'ffffff'
          table.column(1).style {|c| c.align = :center }
          table.column(2).style {|c| c.align = :center }
        end
      end
      pdf.move_down 10
      FirestopStatementReport::GraphPage.new(@job).write(pdf)
    end  
  end

  def uniq_records(facility_id)
    get_data = Lsspdfasset.select(:id, :u_tag, :u_report_type).where( :u_facility_id => facility_id, :u_report_type => ["FIRESTOPINSTALLATION", "FIRESTOPSURVEY"], :u_delete => false).group(["u_report_type", "u_tag"]).order('updated_at desc').count(:u_tag)
    repar_ids = []
    get_data.each do |key,val|
        if val > 1
         repar_ids << Lsspdfasset.select(:id).where(:u_facility_id => facility_id, :u_tag =>key[1], :u_report_type => key[0], :u_delete => false).order('updated_at desc').first
        else
         repar_ids << Lsspdfasset.select(:id).where(:u_facility_id => facility_id, :u_tag =>key[1], :u_report_type => key[0], :u_delete => false).order('updated_at desc').first
        end
      end
     ids = repar_ids.collect(&:id)
  end

end
