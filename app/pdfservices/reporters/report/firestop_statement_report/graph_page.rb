module FirestopStatementReport 
  class GraphPage
    #include DataPageWritable

    def initialize(job)
      @job = job
    end

    def write(pdf)
      top = 415 - pdf.bounds.absolute_bottom
      if File.exists?(issues_path)
        Report::Graph.new('ISSUES', issues_path, [0, top]).draw(pdf)
      end
    end

  private

    def issues_path
      @job.graph_top_issues_path
    end
  end
end
