module FirestopSurveyReport
  class GraphPage
    #include DataPageWritable

    def initialize(job, watermark)
      @job = job
      #@tech = tech
      @watermark = watermark
    end

    def write(pdf)
      #super
      #top = 400 - pdf.bounds.absolute_bottom
      pdf.stamp_at "watermark", [100, 210] if @watermark 
      top = 415 - pdf.bounds.absolute_bottom
      if File.exists?(issues_path)
        #Report::Graph.new('ISSUES', issues_path, [111, top]).draw(pdf)
        #Report::Graph.new('ISSUES', issues_path, [160, top]).draw(pdf)
        Report::Graph.new('ISSUES', issues_path, [0, top]).draw(pdf)
      end
    end

  private

    def issues_path
      @job.graph_top_issues_path
    end
  end
end