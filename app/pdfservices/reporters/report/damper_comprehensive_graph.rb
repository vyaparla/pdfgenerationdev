module Report
  class DamperComprehensiveGraph
    def initialize(owner)
      @owner = owner
    end

    def draw(pdf)
      draw_dr_building_graph(pdf)
      draw_dr_type_graph(pdf)
      draw_dr_result_graph(pdf)
      @naRecords = Lsspdfasset.select(:u_non_accessible_reasons).where(u_facility_id: @owner.u_facility_id, :u_delete => false, :u_report_type => ["DAMPERREPAIR", "DAMPERINSPECTION"]).where.not(u_non_accessible_reasons: "").group(["u_non_accessible_reasons"]).count(:u_non_accessible_reasons)
      if @naRecords.length != 0
        draw_na_reason_graph(pdf)
      else
        draw_na_reason_placeholder(pdf)
      end
    end

  private
  
    def draw_dr_building_graph(pdf)
      Report::Graph.new('BUILDING', @owner.dr_graph_by_building_path, [-35, 512]).draw(pdf)
    end

    def draw_dr_type_graph(pdf)
      #Report::Graph.new('TYPE', @owner.dr_graph_by_type_path, [320, 512]).draw(pdf)
      Report::Graph.new('TYPE', @owner.dr_graph_by_type_path, [280, 512]).draw(pdf)
    end

    def draw_dr_result_graph(pdf)
      top = 390 - pdf.bounds.absolute_bottom
      Report::Graph.new('RESULT', @owner.dr_graph_by_result_path, [-20, 240]).draw(pdf)
    end

    def draw_na_reason_graph(pdf)
      #Report::Graph.new('NA REASON', @owner.graph_na_reasons_path, [240, 237]).draw(pdf)
      Report::Graph.new('NA REASON', @owner.graph_na_reasons_path, [240, 240]).draw(pdf)
    end

    def draw_na_reason_placeholder(pdf)
      pdf.draw_text("#{I18n.t('ui.graphs.na_reasons.no_na_reasons')}", style: :bold, size: 12, at: [300, 112])
    end
  end
end
