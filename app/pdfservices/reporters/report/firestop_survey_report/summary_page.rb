module FirestopSurveyReport
  class SummaryPage
  	include DataPageWritable

  	def initialize(job, tech)
      @job = job
      @tech = tech
    end

    def write(pdf)
      super
      pdf.font "Helvetica"
      pdf.font_size 40
      pdf.fill_color "f39d27"
      pdf.text("<b>Project Summary</b>", inline_format: true)
      pdf.move_down 15
      pdf.fill_color '202020'
      #begin small tables
      pdf.font_size 15
      pdf.fill_color "f39d27"
      pdf.text("<b>Statistics</b>", inline_format: true)

      #Jira LSP-1067 : Until LSS moves into a direction of consistency across the naming conventions, you can replace Deficiency for Issue in the Firestop report examples.
      pdf.move_down 10
      pdf.font_size 15
      pdf.fill_color 'c6171e'
      @total_issue = Lsspdfasset.where(:u_service_id => @job.u_service_id, :u_delete => false).collect(&:u_issue_type).count
      pdf.text("<b>Total # of Issue : </b> #{@total_issue}", inline_format: true)      
      @issue_fixed_on_site = 0
      @issue_survey_only = 0
      @issue_types = Lsspdfasset.select(:u_issue_type, :u_service_type).where(:u_service_id => @job.u_service_id, :u_delete => false).group(["u_service_type"]).count(:u_service_type)      
      @issue_types.each do |key, value|        
        if key == "Fixed On Site"
          @issue_fixed_on_site = value
        else
          @issue_survey_only = value
        end
      end
      pdf.text("<b>Total # of Issue Fixed on Site : </b> #{@issue_fixed_on_site}", inline_format: true)
      pdf.text("<b>Total # of Issue Remaining : </b> #{@issue_survey_only}", inline_format: true) 
      
      #End Jira LSP-1067

      pdf.fill_color '202020'
      pdf.move_down 10
      pdf.font_size 10
      survey_issue_summary = []
      survey_issue_summary << ["Statistic by issue", "Total", "%"]
      @firestop_survey_summary = Lsspdfasset.select(:u_issue_type).where(:u_service_id => @job.u_service_id, :u_delete => false).group(["u_issue_type"]).count(:u_issue_type)
      @firestop_survey_issue_count = 0
      @firestop_survey_summary.each do |key, value|
        @firestop_survey_issue_count += value
        #survey_issue_summary << [key, value, "#{((value * 100) / @firestop_survey_issue_count).round(2)}%"]
      end
      
      @firestop_survey_summary.each do |key, value|
        survey_issue_summary << [key, value, "#{((value.to_f * 100 ) / @firestop_survey_issue_count).round(2)}%"]
      end

      pdf.font_size 10
      pdf.table(survey_issue_summary, header: true) do |table|
        table.row_colors = ['ffffff', 'eaeaea']
        table.rows(0).style {|r| r.border_color = '888888'}
        table.rows(1..(table.row_length-1)).style do |r|
          r.border_color = 'cccccc'
        end
        table.row(0).style background_color: '444444',
                           text_color:       'ffffff'
        table.column(1).style {|c| c.align = :center }
        table.column(2).style {|c| c.align = :center }
      end
      pdf.move_down 50
      FirestopSurveyReport::GraphPage.new(@job).write(pdf)
    end
  end
end