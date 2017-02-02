module Report
  class Graph
    def initialize(title, path, origin)
      @title = title
      @path = path
      @origin = origin
    end

    def draw(pdf)
      begin
      	pdf.image(@path, :at => @origin, :scale => 0.24)
      rescue => error
      	Rails.logger.info("#{Time.now.inspect} ERROR W/ #{@title} GRAPH:\n#{error.message}")
      end
    end
  end
end