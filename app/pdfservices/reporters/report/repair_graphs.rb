module Report
  class RepairGraphs
  	def initialize(owner)
      @owner = owner
    end

    def draw(pdf)
      draw_dr_building_graph(pdf)
      draw_dr_type_graph(pdf)
      draw_dr_result_graph(pdf)
    end

  private
  
    def draw_dr_building_graph(pdf)
      Report::Graph.new('BUILDING', @owner.dr_graph_by_building_path, [-35, 512]).draw(pdf)
    end

    def draw_dr_type_graph(pdf)
      Report::Graph.new('TYPE', @owner.dr_graph_by_type_path, [320, 512]).draw(pdf)
    end

    def draw_dr_result_graph(pdf)
      top = 390 - pdf.bounds.absolute_bottom
      Report::Graph.new('RESULT', @owner.dr_graph_by_result_path, [130, top]).draw(pdf)
    end
  end
end