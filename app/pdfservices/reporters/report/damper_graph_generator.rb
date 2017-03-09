module Report
  class DamperGraphGenerator
  	include FileWritable

    def initialize(owner)
      @owner = owner
    end

    def generate
      generate_building_graph
      generate_type_graph
      generate_result_graph
      generate_na_reason_graph
    end

  private

    def generate_building_graph
      @serviceRecords = Lsspdfasset.select(:u_building).where(:u_service_id => @owner.u_service_id, :u_delete => false).where("u_status !=?", "Removed").group(["u_building"]).count(:u_type)
      @building_graph = []
      @graph_count = 0
      @serviceRecords.each do |key, value|
        @graph_count += value
      end
      
      @serviceRecords.each do |key1, value1|
        @building_graph << [key1, ((value1.to_f * 100) / @graph_count)]
      end
      generate_graph(I18n.t('ui.graphs.by_building.title'), @building_graph, @owner.graph_by_building_path)
    end

    def generate_type_graph
      @typeRecords = Lsspdfasset.select(:u_type).where(:u_service_id => @owner.u_service_id, :u_delete => false).where("u_status !=?", "Removed").group(["u_type"]).count(:u_type)
      @type_graph = []
      @type_graph_count = 0
      @typeRecords.each do |key, value|
        @type_graph_count += value        
      end
      
      @typeRecords.each do |key1, value1|
        Rails.logger.debug("Generate Graph Type KEYS : #{key1.inspect}")
        if key1 == "FSD"
          @gtype = "Fire/Smoke Damper"
        elsif key1 == "FD"
          @gtype = "Fire Damper"
        else
          @gtype = "Smoke Damper"
        end
        @type_graph << [@gtype, ((value1.to_f * 100) / @type_graph_count)]        
      end
      generate_graph(I18n.t('ui.graphs.by_type.title'), @type_graph, @owner.graph_by_type_path)
    end

    def generate_result_graph
      @resultRecords = Lsspdfasset.select(:u_status).where(:u_service_id => @owner.u_service_id, :u_delete => false).where("u_status !=?", "Removed").group(["u_status"]).count(:u_status)
      @result_graph = []
      @result_graph_count = 0
      @resultRecords.each do |key, value|
        @result_graph_count += value        
      end
      
      @resultRecords.each do |key1, value1|
        Rails.logger.debug("Generate Graph Result KEYS : #{key1.inspect}")
        if key1 == "Fail"
          @gtype = "Failed"
        elsif key1 == "NA"
          @gtype = "Non Accessible"
        else
          @gtype = "Passed"
        end
        @result_graph << [@gtype, ((value1.to_f * 100) / @result_graph_count)]        
      end
      generate_graph(I18n.t('ui.graphs.by_result.title'), @result_graph, @owner.graph_by_result_path)
    end

    def generate_na_reason_graph
      #@naRecords = Lsspdfasset.select(:u_non_accessible_reasons).where("u_service_id =? AND u_non_accessible_reasons IS NOT NULL", @owner.u_service_id).group(["u_non_accessible_reasons"]).count(:u_non_accessible_reasons)
      @naRecords = Lsspdfasset.select(:u_non_accessible_reasons).where(u_service_id: @owner.u_service_id, :u_delete => false).where.not(u_non_accessible_reasons: "").group(["u_non_accessible_reasons"]).count(:u_non_accessible_reasons)
      #Rails.logger.debug("NA Records Length : #{@naRecords.length.inspect}")
      if @naRecords.length != 0
        Rails.logger.debug("IF Condition NA Records : #{@naRecords.inspect}")
        @na_graph = []
        @na_graph_total = 0
        @naRecords.each do |key, value|
          @na_graph_total += value
        end
   
        @naRecords.each do |key1, value1|
          @na_graph << [key1,  ((value1.to_f * 100) / @na_graph_total)]
        end
        generate_pie_graph(I18n.t('ui.graphs.na_reasons.title'), @na_graph, @owner.graph_na_reasons_path)
      end
    end

    def generate_graph(title, data, file)
      gbar = Gruff::Bar.new('1000x1000')
      gbar.theme = {
        :marker_color      => '#aaa',
        :colors            => %w(#e3553f #f39d27 #94b463 #568ac6 #5e723f #8e3629
                                 #385a81 #aa6d19 #e3bf42),
        :background_colors => %w(white white)
      }
      gbar.font = "#{Rails.root}/lib/pdf_generation/fonts/Helvetica.ttf"
      gbar.title_font_size = 40
      gbar.legend_font_size = 30
      gbar.marker_font_size = 24
      gbar.bottom_margin = 10
      gbar.title_margin = 10
      gbar.sort = false
      gbar.maximum_value = 100 
      gbar.minimum_value = 0 
      gbar.y_axis_increment = 20
      gbar.title = title
      data.each {|d| gbar.data d.first, d.last}
      make_directory(file)
      gbar.write(file)
    end
  
    def generate_pie_graph(title, data, file)
      pie = Gruff::Pie.new('1333x1000')
      pie.theme = {
        :marker_color      => '#aaa',
        :colors            => %w(#e3553f #f39d27 #94b463 #568ac6 #5e723f #8e3629
                                 #385a81 #aa6d19 #e3bf42),
        :background_colors => %w(white white)
      }
      pie.font = File.expand_path('lib/pdf_generation/fonts/Helvetica.ttf',
                                  Rails.root)
      pie.title_font_size = 24
      pie.legend_font_size = 24
      pie.marker_font_size = 24
      pie.bottom_margin = 50
      pie.title_margin = 50
      pie.title = title
      data.each { |d| pie.data d.first, d.last }
      make_directory(file)
      pie.write(file)
    end
  end
end