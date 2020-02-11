module DamperComprehensiveReport
  class GraphGenerator
  	include FileWritable

    def initialize(job)
      @job = job      
    end

    def generate
      generate_dr_building_graph
      generate_dr_type_graph
      generate_dr_result_graph
      generate_na_reason_graph
    end

  private

    def generate_dr_building_graph
      @dr_buildingInfo = Lsspdfasset.select(:u_building).where(u_facility_name: @job.u_facility_name, u_report_type: ["DAMPERREPAIR" ,"DAMPERINSPECTION"], :u_delete => false).where.not(u_type: "").group(["u_building"]).count(:u_type) if !@job.u_facility_name.blank?
      @dr_building_graph = []
      @dr_graph_count = 0
      @dr_buildingInfo.each do |key, value|
        @dr_graph_count += value
      end
      @dr_buildingInfo.each do |key1, value1|
      	@dr_building_graph << [key1, ((value1.to_f * 100) / @dr_graph_count)]
      end
      #dr_generate_graph(I18n.t('ui.graphs.by_building.title'), @dr_building_graph, @job.dr_graph_by_building_path)
      dr_generate_pie_graph(I18n.t('ui.graphs.by_building.title'), @dr_building_graph, @job.dr_graph_by_building_path)
    end

    def generate_dr_type_graph
      @dr_typeRecords = Lsspdfasset.select(:u_type).where(u_facility_name: @job.u_facility_name, u_report_type: ["DAMPERREPAIR" ,"DAMPERINSPECTION"], :u_delete => false).where.not(u_type: "").group(["u_type"]).order("CASE WHEN u_type = 'FD' THEN '1' WHEN u_type = 'SD' THEN '2' ELSE '3' END").count(:u_type)
      @dr_type_graph = []      
      @dr_type_graph_count = 0
      @dr_typeRecords.each do |key, value|
        @dr_type_graph_count += value
      end

      @dr_typeRecords.each do |key1, value1|
        if key1 == "FD"
          @dr_gtype = "Fire"
        elsif key1 == "SD"
          @dr_gtype = "Smoke"
        else
          @dr_gtype = "Combination"
        end
        @dr_type_graph << [@dr_gtype, ((value1.to_f * 100) / @dr_type_graph_count)]
      end
      #dr_generate_graph(I18n.t('ui.graphs.by_type.title'), @dr_type_graph, @job.dr_graph_by_type_path)
      dr_generate_pie_graph(I18n.t('ui.graphs.by_type.title'), @dr_type_graph, @job.dr_graph_by_type_path)
    end

    def generate_dr_result_graph
     @damper_repair = Lsspdfasset.select(:u_dr_passed_post_repair).where(u_facility_name: @job.u_facility_name, u_report_type: ["DAMPERREPAIR" ,"DAMPERINSPECTION"], :u_delete => false).group(["u_dr_passed_post_repair"]).order("CASE WHEN u_dr_passed_post_repair = 'PASS' THEN '1' WHEN u_dr_passed_post_repair = 'Fail' THEN '2' ELSE '3' END").count(:u_dr_passed_post_repair)
     @damper_inspection = Lsspdfasset.select(:u_status).where(u_facility_name: @job.u_facility_name, u_report_type: ["DAMPERREPAIR" ,"DAMPERINSPECTION"], :u_delete => false).group(["u_status"]).order("CASE WHEN u_status = 'PASS' THEN '1' WHEN u_status = 'Fail' THEN '2' ELSE '3' END").count(:u_status)

      new_array = @damper_repair.to_a + @damper_inspection.to_a
      status_counts = new_array.group_by{|i| i[0]}.map{|k,v| [k, v.map(&:last).sum] } 

     # @dr_resultRecords = Lsspdfasset.select(:u_dr_passed_post_repair).where(u_facility_name: @job.u_facility_name, u_report_type: ["DAMPERREPAIR" ,"DAMPERINSPECTION"], :u_delete => false).group(["u_dr_passed_post_repair"]).order("CASE WHEN u_dr_passed_post_repair = 'PASS' THEN '1' WHEN u_dr_passed_post_repair = 'Fail' THEN '2' ELSE '3' END").count(:u_dr_passed_post_repair)
      @dr_resultRecords = status_counts.to_h

      @dr_result_graph = []
      @dr_result_graph_count = 0
      @dr_resultRecords.each do |key, value|
        @dr_result_graph_count += value
      end

      @dr_resultRecords.each do |key1, value1|
        if key1 == "Pass"
          @dr_status = "Passed"
        elsif key1 == "Fail"
          @dr_status = "Failed"
        else
          @dr_status = "Non Accessible"
        end 
       @dr_result_graph << [@dr_status, ((value1.to_f * 100) / @dr_result_graph_count)]
      end
      dr_generate_pie_graph(I18n.t('ui.graphs.by_result.title'), @dr_result_graph, @job.dr_graph_by_result_path)
    end

    def generate_na_reason_graph
      #@naRecords = Lsspdfasset.select(:u_non_accessible_reasons).where("u_service_id =? AND u_non_accessible_reasons IS NOT NULL", @owner.u_service_id).group(["u_non_accessible_reasons"]).count(:u_non_accessible_reasons)
      #@dr_resultRecords = Lsspdfasset.select(:u_dr_passed_post_repair).where(u_facility_name: @job.u_facility_name, u_report_type: ["DAMPERREPAIR" ,"DAMPERINSPECTION"], :u_delete => false).group(["u_dr_passed_post_repair"]).order("CASE WHEN u_dr_passed_post_repair = 'PASS' THEN '1' WHEN u_dr_passed_post_repair = 'Fail' THEN '2' ELSE '3' END").count(:u_dr_passed_post_repair)
      @naRecords = Lsspdfasset.select(:u_non_accessible_reasons).where(u_facility_name: @job.u_facility_name, u_report_type: ["DAMPERREPAIR" ,"DAMPERINSPECTION"], :u_delete => false).where.not(u_non_accessible_reasons: "").where.not(u_type: "").group(["u_non_accessible_reasons"]).count(:u_non_accessible_reasons)
      #Rails.logger.debug("NA Records Length : #{@naRecords.length.inspect}")
      if @naRecords.length != 0
        #Rails.logger.debug("IF Condition NA Records : #{@naRecords.inspect}")
        @na_graph = []
        @na_graph_total = 0
        @naRecords.each do |key, value|
          @na_graph_total += value
        end
   
        @naRecords.each do |key1, value1|
          @na_graph << [key1,  ((value1.to_f * 100) / @na_graph_total)]
        end
        dr_generate_pie_graph(I18n.t('ui.graphs.na_reasons.title'), @na_graph, @job.dr_graph_na_reasons_path)
      end
    end

    def dr_generate_graph(title, data, file)
      gbar = Gruff::Bar.new('1000x1000')
      gbar.theme = {
        :marker_color      => '#aaa',
        :colors            => %w(#e3553f #f39d27 #94b463 #568ac6 #5e723f #8e3629
                                 #385a81 #aa6d19 #e3bf42),
        :background_colors => %w(white white)
      }
      gbar.title_font_size = 30
      gbar.legend_font_size = 30
      gbar.marker_font_size = 24
      gbar.bottom_margin = 10
      gbar.title_margin = 50
      gbar.sort = false
      gbar.maximum_value = 100
      gbar.minimum_value = 0 
      gbar.y_axis_increment = 20
      gbar.title = title
      data.each {|d| gbar.data d.first, d.last}
      make_directory(file)
      gbar.write(file)
    end
    
    def dr_generate_pie_graph(title, data, file)
      pie = Gruff::Pie.new('1333x1000')
      pie.theme = {
        :marker_color      => '#aaa',
        :colors            => %w(#e3553f #f39d27 #94b463 #568ac6 #5e723f #8e3629
                                 #385a81 #aa6d19 #e3bf42),
        :background_colors => %w(white white)
      }
      pie.title_font_size = 30
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