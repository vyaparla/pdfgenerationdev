module FirestopInstallationReport
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
      g =  Gruff::Bar.new('1333x1000')
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

      @firestop_installation_summary = Lsspdfasset.select(:u_issue_type).where(:u_service_id => @job.u_service_id, :u_delete => false).group(["u_issue_type"]).count(:u_issue_type)
      @firestop_installation_issue_count = 0
      @firestop_installation_summary.each do |key, value|
        @firestop_installation_issue_count += value
      end
      
      @installation_issue_graph = []
      @firestop_installation_summary.each do |key1, value1|
        @installation_issue_graph << [key1, ((value1.to_f * 100) / @firestop_installation_issue_count)]
      end

      data = @installation_issue_graph
      data.each {|d| g.data d.first, d.last}
      make_directory(@job.installation_top_issue_path)
      g.write(@job.installation_top_issue_path)
    end
  end
end