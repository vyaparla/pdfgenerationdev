module Report
  class BuildingSummary
  	include SummaryDrawable

    def initialize(owner, building)
      @owner = owner
      @building = building      
    end

  private

    def building
      @building
    end

    def title
      I18n.t('ui.inspection_report_pdf.building_summary_page.title')
    end

    def summary_table_headings
      table_column_headings(:floor)
    end

    # def summary_table_data
    #   #[["1", "5", "5", "5", "5", "5", "5"], ["2", "5", "5", "5", "5", "5", "5"]]
    #   #@building.floors.map { |f,| summary_table_row(f) 
    #   @buildingInfo = Lsspdfasset.select(:u_building,:u_floor,:u_type).where(:u_service_id => @owner.u_service_id, :u_building => @building).group(["u_building", "u_floor", "u_type"]).order(:u_floor).count(:u_type)
    #   @floorInfo = []    
    #   @buildingInfo.each do |key,value|
    #     floor_json = {}
    #     if @floorInfo.length == 0
          
    #       floor_json["building"] = key[0]
    #       floor_json["floor"] = key[1]

    #       if key[2] == "FSD"
    #         floor_json["FSD"] = value
    #         floor_json["FD"] = 0
    #         floor_json["SD"] = 0
    #       elsif key[2] == "FD"
    #         floor_json["FSD"] = 0
    #         floor_json["FD"] = value
    #         floor_json["SD"] = 0
    #       else
    #         floor_json["FSD"] = 0
    #         floor_json["FD"] = 0
    #         floor_json["SD"] = value
    #       end
    #       @building_result = Lsspdfasset.select(:u_building, :u_floor, :u_status).where(:u_service_id => @owner.u_service_id, :u_building => @building, :u_floor => key[1]).group(["u_building", "u_floor", "u_status"]).count(:u_status)

    #       @building_result.each do |fstatus, fvalue|
    #         if !floor_json.has_key?(fstatus[2])
    #           floor_json[fstatus[2]] = fvalue
    #         end
    #       end

    #       if !floor_json.has_key?("Pass")
    #         floor_json["Pass"] = 0
    #       end

    #       if !floor_json.has_key?("Fail")
    #         floor_json["Fail"] = 0
    #       end

    #        if !floor_json.has_key?("NA")
    #         floor_json["NA"] = 0
    #       end
          
    #       @floorInfo.push(floor_json)
    #     else
    #       @boolean = 0
    #       @floorInfo.each do |info|
    #         @damperType = key[2]
    #         if info.has_key?(key[2])
    #           if info["floor"] == key[1]
    #             info[key[2]] = value
    #             @boolean = 1
    #           end
    #         end
    #       end

    #       if @boolean == 0
    #         #floor_json = {}
    #         floor_json["building"] = key[0]
    #         floor_json["floor"] = key[1]
    #         if key[2] == "FSD"
    #           floor_json["FSD"] = value
    #           floor_json["FD"] = 0
    #           floor_json["SD"] = 0
    #         elsif key[2] == "FD"
    #           floor_json["FSD"] = 0
    #           floor_json["FD"] = value
    #           floor_json["SD"] = 0
    #         else
    #           floor_json["FSD"] = 0
    #           floor_json["FD"] = 0
    #           floor_json["SD"] = value
    #         end
            
    #         @building_result = Lsspdfasset.select(:u_building, :u_floor, :u_status).where(:u_service_id => @owner.u_service_id, :u_building => @building, :u_floor => key[1]).group(["u_building", "u_floor", "u_status"]).count(:u_status)
    #         @building_result_len =  @building_result.length
    
    #         @building_result.each do |fstatus, fvalue|
    #          if !floor_json.has_key?(fstatus[2])
    #            floor_json[fstatus[2]] = fvalue
    #           end
    #         end

    #         if !floor_json.has_key?("Pass")
    #           floor_json["Pass"] = 0
    #         end

    #         if !floor_json.has_key?("Fail")
    #           floor_json["Fail"] = 0
    #         end

    #         if !floor_json.has_key?("NA")
    #           floor_json["NA"] = 0
    #         end

    #         @floorInfo.push(floor_json)
    #       end
    #     end  
    #     #Rails.logger.debug("FloorJson : #{@floorInfo.inspect}")
    #   end
    #   #Rails.logger.debug("FloorJson : #{@floorInfo.inspect}")

    #   @final_table_data = []
    #   @floorInfo.each do |resultInfo|
    #     @damperPer = '%.2f%' % ((resultInfo["Pass"] * 100) / (resultInfo["FSD"] + resultInfo["FD"] + resultInfo["SD"]))
    #     @final_table_data << [resultInfo["floor"], resultInfo["FSD"], resultInfo["FD"], resultInfo["SD"], resultInfo["Pass"], resultInfo["Fail"], resultInfo["NA"], resultInfo["FSD"] + resultInfo["FD"] + resultInfo["SD"], @damperPer]
    #   end
    
    #   @final_table_data_total = []
    #   @fsdtotal = 0
    #   @fdtotal = 0
    #   @sdtotal = 0
    #   @ptotal = 0
    #   @ftotal = 0
    #   @natotal = 0

    #   @floorInfo.each do |totalInfo|
    #     #Rails.logger.debug("FloorJson : #{totalInfo["FSD"].inspect}")
    #     @fsdtotal += totalInfo["FSD"]
    #     #Rails.logger.debug("FloorJson : #{@fsdtotal.inspect}")
    #     @fdtotal += totalInfo["FD"]
    #     @sdtotal += totalInfo["SD"]
    #     @ptotal += totalInfo["Pass"]
    #     @ftotal += totalInfo["Fail"]
    #     @natotal += totalInfo["NA"]
    #   end
 
    #   @final_table_data_total.push(@fsdtotal)
    #   @final_table_data_total.push(@fdtotal)
    #   @final_table_data_total.push(@sdtotal)
    #   @final_table_data_total.push(@ptotal)
    #   @final_table_data_total.push(@ftotal)
    #   @final_table_data_total.push(@natotal)
    #   @final_table_data_total.push(@fsdtotal + @fdtotal + @sdtotal)

    #   @ptotal_damperPer = '%.2f%' % ((@ptotal * 100) / (@fsdtotal + @fdtotal + @sdtotal))
    #   @ftotal_damperPer = '%.2f%' % ((@ftotal * 100) / (@fsdtotal + @fdtotal + @sdtotal))
    #   @natotal_damperPer = '%.2f%' % ((@natotal * 100) / (@fsdtotal + @fdtotal + @sdtotal))

    #   @final_table_data_total.push(@ptotal_damperPer)

    #   @final_table_data + [['GRAND TOTAL'] + @final_table_data_total]

    #   result_data(@ptotal_damperPer, @ftotal_damperPer, @natotal_damperPer)
    #   type_data(@fsdtotal, @fdtotal, @sdtotal)
    #   #Rails.logger.debug("Floor Final Result : #{@final_table_data.inspect}")
    # end
 
    # def result_data(pass_per, fail_per, na_per)
    #   Rails.logger.debug("Result Data : #{pass_per.inspect} - #{fail_per.inspect} - #{na_per.inspect}")

    #   [[DamperInspectionReporting.column_heading(:pass), pass_per],
    #    [DamperInspectionReporting.column_heading(:fail), fail_per],
    #    [DamperInspectionReporting.column_heading(:na), na_per]]
    # end

    # def type_data(fsdtotal, fdtotal, sdtotal)
    #   Rails.logger.debug("Type Data : #{fsdtotal.inspect} - #{fdtotal.inspect} - #{sdtotal.inspect}")
    #   @comb_damperPer = '%.2f%' % ((fsdtotal * 100) / (fsdtotal + fdtotal + sdtotal))
    #   @fire_damperPer = '%.2f%' % ((fdtotal * 100) / (fsdtotal + fdtotal + sdtotal))
    #   @smoke_damperPer = '%.2f%' % ((sdtotal * 100) / (fsdtotal + fdtotal + sdtotal))
    #   [["Fire/Somke Damper", fsdtotal, @comb_damperPer], ["Fire", fdtotal, @fire_damperPer], ["Smoke", sdtotal, @smoke_damperPer]]
    # end
  end
end