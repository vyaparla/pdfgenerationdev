module FirestopSurveyReport
  class GraphPage
    include DataPageWritable

    def initialize(job)
      @job = job
    end

    def write(pdf)
      super
      top = 662 - pdf.bounds.absolute_bottom
      if File.exists?(issues_path)
        Report::Graph.new('ISSUES', issues_path, [111, top]).draw(pdf)
      end
    end

  private

    def issues_path
      @job.graph_top_issues_path
    end
  end
end