module FirestopInstallationReport
  class SummaryPage
  	include Report::DataPageWritable

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
      pdf.font_size 15
      pdf.fill_color "f39d27"
      pdf.text("<b>Statistics</b>", inline_format: true)
      

      #Jira LSP-1067 : Until LSS moves into a direction of consistency across the naming conventions, you can replace Deficiency for Issue in the Firestop report examples.
      pdf.move_down 10
      pdf.font_size 15
      pdf.fill_color 'c6171e'      
      @total_issue = Lsspdfasset.where(:u_service_id => @job.u_service_id, :u_delete => false).collect(&:u_issue_type).count
      pdf.text("<b>Total # of Issue : </b> #{@total_issue}", inline_format: true)
      @issue_types = Lsspdfasset.select(:u_issue_type, :u_service_type).where(:u_service_id => @job.u_service_id, :u_delete => false).group(["u_service_type"]).count(:u_service_type)
      @toal_issue_types = @issue_types.values
      pdf.text("<b>Total # of Issue Fixed on Site : </b> #{@toal_issue_types[0]}", inline_format: true)
      pdf.text("<b>Total # of Issue Remaining : </b> #{@toal_issue_types[1]}", inline_format: true)
      #End Jira LSP-1067

      pdf.fill_color '202020'
      pdf.move_down 10
      pdf.font_size 10

      installation_issue_summary = []
      installation_issue_summary << ["Statistic by issue", "Total", "%"]
      @firestop_installation_summary = Lsspdfasset.select(:u_issue_type).where(:u_service_id => @job.u_service_id, :u_delete => false).group(["u_issue_type"]).count(:u_issue_type)
      @firestop_installation_issue_count = 0
      @firestop_installation_summary.each do |key, value|
        @firestop_installation_issue_count += value
        #survey_issue_summary << [key, value, "#{((value * 100) / @firestop_survey_issue_count).round(2)}%"]
      end
      
      @firestop_installation_summary.each do |key, value|
        installation_issue_summary << [key, value, "#{((value.to_f * 100 ) / @firestop_installation_issue_count).round(2)}%"]
      end

      pdf.font_size 10
      pdf.table(installation_issue_summary, header: true) do |table|
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
      FirestopInstallationReport::GraphPage.new(@job).write(pdf)
    end

  private
  
    def date_key
      :installation_date
    end

    def technician_key
      :installed_by
    end
  end
end