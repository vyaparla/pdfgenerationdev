module Report
  class DamperGraphs

  	def initialize(owner)
      @owner = owner
    end

    def draw(pdf)
      draw_building_graph(pdf)
      draw_type_graph(pdf)
      draw_result_graph(pdf)
      # @naRecords = Lsspdfasset.select(:u_non_accessible_reasons).where("u_service_id =? AND u_non_accessible_reasons IS NOT NULL", @owner.u_service_id).group(["u_non_accessible_reasons"]).count(:u_non_accessible_reasons)
      @naRecords = Lsspdfasset.select(:u_non_accessible_reasons).where(u_service_id: @owner.u_service_id).where.not(u_non_accessible_reasons: nil).group(["u_non_accessible_reasons"]).count(:u_non_accessible_reasons)
      if @naRecords != 0
        draw_na_reason_graph(pdf)
      else
        draw_na_reason_placeholder(pdf)
      end
    end

  private

    def draw_building_graph(pdf)
      Report::Graph.new('BUILDING', @owner.graph_by_building_path, [-20, 512]).draw(pdf)
    end

    def draw_type_graph(pdf)
      Report::Graph.new('TYPE', @owner.graph_by_type_path, [260, 512]).draw(pdf)
    end

    def draw_result_graph(pdf)
      Report::Graph.new('RESULT', @owner.graph_by_result_path, [-20, 237]).draw(pdf)
    end

    def draw_na_reason_graph(pdf)
      Report::Graph.new('NA REASON', @owner.graph_na_reasons_path, [240, 237]).draw(pdf)
    end

    def draw_na_reason_placeholder(pdf)
      pdf.draw_text("#{I18n.t('ui.graphs.na_reasons.no_na_reasons')}", style: :bold, size: 12, at: [300, 112])
    end
  end
end