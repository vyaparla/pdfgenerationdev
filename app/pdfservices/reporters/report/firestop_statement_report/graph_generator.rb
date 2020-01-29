module FirestopStatementReport 
  class GraphGenerator
    include FileWritable

    def initialize(job)
      @job = job
    end

    def generate
      graph_top_issues
    end

  private

    def graph_top_issues
      g = Gruff::Pie.new('1333x1000')
      g.theme = {
        :marker_color => '#aaa',
        :colors => %w(#e3553f #f39d27 #94b463 #568ac6 #5e723f #8e3629 #385a81
                      #aa6d19 #e3bf42),
        :background_colors => ['#fff', '#fff']
      }
      g.font = File.expand_path('lib/pdf_generation/fonts/Helvetica.ttf', Rails.root)
      g.title_font_size = 24
      g.legend_font_size = 24
      g.marker_font_size = 24
      g.bottom_margin = 50
      g.title = 'ISSUES'
      g.title_margin = 50
      g.sort = false
      g.maximum_value = 100 
      g.minimum_value = 0
      g.y_axis_increment = 20
      get_ids = @job.uniq_records(@job.u_facility_id)
      @firestop_survey_summary = Lsspdfasset.select(:u_issue_type).where(:id => get_ids).group(["u_issue_type"]).count(:u_issue_type)
      @firestop_survey_issue_count = 0
      @firestop_survey_summary.each do |key, value|
        @firestop_survey_issue_count += value
      end
      
      @survey_issue_graph = []
      @firestop_survey_summary.each do |key1, value1|
        @survey_issue_graph << [key1, ((value1.to_f * 100) / @firestop_survey_issue_count)]
      end

      data = @survey_issue_graph
      
      data.each {|d| g.data d.first, d.last}
      make_directory(@job.graph_top_issues_path)
      g.write(@job.graph_top_issues_path)
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
