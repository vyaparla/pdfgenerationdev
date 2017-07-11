module Report
  class DoorGraphs
  	def initialize(owner)
      @owner = owner
    end

    def draw(pdf)
      draw_firedoor_door_by_rating(pdf)
    end

  private

    def draw_firedoor_door_by_rating(pdf)
      #Report::Graph.new('BUILDING', @owner.dr_graph_by_building_path, [-35, 512]).draw(pdf)
      top = 578 - pdf.bounds.absolute_bottom
      Report::Graph.new('Fire Rating', @owner.graph_firedoor_door_by_rating_path, [115, top]).draw(pdf)
    end
  end
end