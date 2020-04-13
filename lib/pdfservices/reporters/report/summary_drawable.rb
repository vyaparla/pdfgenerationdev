module Report
  module SummaryDrawable

  def draw(pdf)
    draw_title(pdf, title)
    Report::Table.new(summary_table_content).draw(pdf)
    pdf.move_down 30
    draw_label(pdf, 'Statistics')
    top = pdf.cursor
    pdf.move_cursor_to top
    Report::Table.new(result_table_content).draw(pdf) do |formatter|
      formatter.cell[1,0] = { :text_color => '137d08' }
      formatter.cell[2,0] = { :text_color => 'c1171d' }
      formatter.cell[3,0] = { :text_color => 'f39d27' }
    end
    pdf.move_down 60
  end

  private
  
    def column_heading(key)
      I18n.t("ui.inspection_report_pdf.table_headings_cols.#{key}")
    end
   
    def draw_label(pdf, text)
      pdf.font_size 20
      pdf.fill_color 'ED1C24'
      pdf.text("<b>#{text}</b>", :inline_format => true)
      pdf.fill_color '202020'
      pdf.move_down 10
    end

    def draw_title(pdf, title)
      pdf.font_size 30
      pdf.fill_color 'ED1C24'
      pdf.text("<b>#{title} - #{@building}</b>", :inline_format => true)
      pdf.fill_color '202020'
      pdf.move_down 10
    end

    def table_column_headings(heading)
      [column_heading(heading)] +
      ["Fire", "Smoke", "Combination"] +
      %i(pass fail na total_dampers damper_per removed).map { |k| column_heading(k)}
    end

    def summary_table_content
      [summary_table_headings] + summary_table_data
    end

#    def summary_table_data
#      @buildingInfo = Lsspdfasset.select(:u_building, :u_floor, :u_type, :u_other_floor).where(:u_service_id => @owner.u_service_id, :u_building => @building, :u_delete => false ).where.not(u_type: "").group(["u_building", "u_floor", "u_type", "u_other_floor"]).order(:u_floor).count(:u_type)
#      @floorInfo = []
#      @buildingInfo.each do |key,value|
#        floor_json = {}
#        if @floorInfo.length == 0
#          
#          floor_json["building"] = key[0]
#	        floor_data = key[1] == "other" ? key[3] : key[1]
#	        floor_json["floor"] = floor_data
#
#          if key[2] == "FSD"
#            floor_json["FSD"] = value
#            floor_json["FD"] = 0
#            floor_json["SD"] = 0
#          elsif key[2] == "FD"
#            floor_json["FSD"] = 0
#            floor_json["FD"] = value
#            floor_json["SD"] = 0
#          else
#            floor_json["FSD"] = 0
#            floor_json["FD"] = 0
#            floor_json["SD"] = value
#          end
#	  if  key[1] == "other"
#	     @building_result = Lsspdfasset.select(:u_building, :u_other_floor, :u_status).where(:u_service_id => @owner.u_service_id, :u_building => @building, :u_other_floor => key[3], :u_delete => false).where.not(u_type: "").group(["u_building", "u_other_floor","u_status"]).count(:u_status)
#          else
#            @building_result = Lsspdfasset.select(:u_building, :u_floor, :u_status).where(:u_service_id => @owner.u_service_id, :u_building => @building, :u_floor => key[1], :u_delete => false).where.not(u_type: "").group(["u_building", "u_floor","u_status"]).count(:u_status)
#           end
#
#          @building_result.each do |fstatus, fvalue|
#            if !floor_json.has_key?(fstatus[2])
#              floor_json[fstatus[2]] = fvalue
#            end
#          end
#
#          if !floor_json.has_key?("Pass")
#            floor_json["Pass"] = 0
#          end
#
#          if !floor_json.has_key?("Fail")
#            floor_json["Fail"] = 0
#          end
#
#          if !floor_json.has_key?("NA")
#            floor_json["NA"] = 0
#          end
#
#          if !floor_json.has_key?("Removed")
#            floor_json["Removed"] = 0
#          end
#          
#          @floorInfo.push(floor_json)
#        else
#          @boolean = 0
#          @floorInfo.each do |info|
#            @damperType = key[2]
#            if info.has_key?(key[2])
#              if info["floor"] == key[1]
#                info[key[2]] = value
#                @boolean = 1
#              end
#            end
#          end
#
#          if @boolean == 0
#            floor_json["building"] = key[0]
#	    floor_data = key[1] == "other" ? key[3] : key[1]
#            floor_json["floor"] = floor_data
#            if key[2] == "FSD"
#              floor_json["FSD"] = value
#              floor_json["FD"] = 0
#              floor_json["SD"] = 0
#            elsif key[2] == "FD"
#              floor_json["FSD"] = 0
#              floor_json["FD"] = value
#              floor_json["SD"] = 0
#            else
#              floor_json["FSD"] = 0
#              floor_json["FD"] = 0
#              floor_json["SD"] = value
#            end
#            if  key[1] == "other"
#	      @building_result = Lsspdfasset.select(:u_building, :u_other_floor, :u_status).where(:u_service_id => @owner.u_service_id, :u_building => @building, :u_other_floor => key[3], :u_delete => false).group(["u_building", "u_other_floor", "u_status"]).count(:u_status)
#          else
#	     @building_result = Lsspdfasset.select(:u_building, :u_floor, :u_status).where(:u_service_id => @owner.u_service_id, :u_building => @building, :u_floor => key[1], :u_delete => false).group(["u_building", "u_floor", "u_status"]).count(:u_status)
#           end
#            @building_result_len =  @building_result.length
#    
#            @building_result.each do |fstatus, fvalue|
#             if !floor_json.has_key?(fstatus[2])
#               floor_json[fstatus[2]] = fvalue
#              end
#            end
#
#            if !floor_json.has_key?("Pass")
#              floor_json["Pass"] = 0
#            end
#
#            if !floor_json.has_key?("Fail")
#              floor_json["Fail"] = 0
#            end
#
#            if !floor_json.has_key?("NA")
#              floor_json["NA"] = 0
#            end
#
#            if !floor_json.has_key?("Removed")
#              floor_json["Removed"] = 0
#            end
#
#            @floorInfo.push(floor_json)
#          end
#        end
#      end
#      
#      @final_table_data_total = []
#      $fsdtotal = 0
#      $fdtotal = 0
#      $sdtotal = 0
#      $ptotal = 0
#      $ftotal = 0
#      $natotal = 0
#      $rtotal = 0
#
#      @floorInfo.each do |totalInfo|
#        $fsdtotal += totalInfo["FSD"]        
#        $fdtotal += totalInfo["FD"]
#        $sdtotal += totalInfo["SD"]
#        $ptotal += totalInfo["Pass"]
#        $ftotal += totalInfo["Fail"]
#        $natotal += totalInfo["NA"]
#        $rtotal += totalInfo["Removed"]
#      end
#      
#      @final_table_data_total.push($fdtotal)
#      @final_table_data_total.push($sdtotal)      
#      @final_table_data_total.push($fsdtotal)
#      @final_table_data_total.push($ptotal)
#      @final_table_data_total.push($ftotal)
#      @final_table_data_total.push($natotal)
#      #@final_table_data_total.push($rtotal)
#      #@final_table_data_total.push("0")
#      #@final_table_data_total.push($sdtotal + $fdtotal + $fsdtotal)
#      @final_table_data_total.push($ptotal + $ftotal + $natotal)
#
#      if $ptotal == 0 && $ftotal == 0 && $natotal == 0
#        @final_table_data_total.push("00.00%")
#      else
#        @final_table_data_total.push("100.00%")
#      end   
#      @final_table_data_total.push($rtotal)
#      Rails.logger.debug("Floor Info :#{@floorInfo.inspect}")
#
#      @final_table_data = []
#      @floorInfo.each do |resultInfo|
#        @damperTotal = resultInfo["Pass"] + resultInfo["Fail"] + resultInfo["NA"]
#        @damperGrandtotal = $ptotal + $ftotal + $natotal
#
#        if @damperTotal == 0 && @damperGrandtotal == 0
#          @damperPer = "00.00%"
#        else
#          @damperPer = '%.2f%' % ((100 * @damperTotal) / (@damperGrandtotal))
#        end        
#        @final_table_data << [resultInfo["floor"], resultInfo["FD"], resultInfo["SD"], resultInfo["FSD"], resultInfo["Pass"], resultInfo["Fail"], resultInfo["NA"],  resultInfo["Pass"] + resultInfo["Fail"] + resultInfo["NA"], @damperPer, resultInfo["Removed"]]
#      end
#    
#
#      if $ptotal == 0 && $ftotal == 0 && $natotal == 0
#        $ptotal_damperPer  = "00.00%"
#        $ftotal_damperPer  = "00.00%"
#        $natotal_damperPer = "00.00%"
#      else
#        $ptotal_damperPer  = '%.2f%' %  (($ptotal.to_f * 100) / ($ptotal + $ftotal + $natotal))
#        $ftotal_damperPer  = '%.2f%' %  (($ftotal.to_f * 100) / ($ptotal + $ftotal + $natotal))
#        $natotal_damperPer = '%.2f%' %  (($natotal.to_f * 100) / ($ptotal + $ftotal + $natotal))
#      end
#     # @final_table_data_total.push($rtotal)
#      #raise @final_table_data.inspect
#      @final_table_data + [['GRAND TOTAL'] + @final_table_data_total]
#    end
#
    # new code
     def summary_table_data
      @buildingInfo = Lsspdfasset.select(:u_building, :u_floor, :u_type, :u_other_floor).where(:u_service_id => @owner.u_service_id, :u_building => @building, :u_delete => false).where.not(u_type: "").group(["u_building", "u_floor", "u_type", "u_other_floor"]).order(:u_floor).count(:u_type)
      building_floors = Lsspdfasset.select(:u_building, :u_floor, :u_type, :u_other_floor).where(:u_service_id => @owner.u_service_id, :u_building => @building, :u_delete => false).where.not(u_type: "").pluck(:u_floor)
      building_other_floors = Lsspdfasset.select(:u_building, :u_floor, :u_type, :u_other_floor).where(:u_service_id => @owner.u_service_id, :u_building => @building, :u_delete => false).where.not(u_type: "").pluck(:u_other_floor)
     
      @floorInfo = []
      @buildingInfo.each do |key,value|
        floor_json = {}
        if @floorInfo.length == 0
          initialize_floor_json(@floorInfo,floor_json, key, value, building_floors, building_other_floors, @buildingInfo)
        else
          @boolean = 0
          @floorInfo.each do |info|
            @damperType = key[2]
            if info.has_key?(key[2])
              if info["floor"] == key[1] || info["floor"] == key[3]
                @boolean = 1
              end
            end

          end

          if @boolean == 0
            initialize_floor_json(@floorInfo,floor_json, key, value, building_floors, building_other_floors, @buildingInfo)
          end
        end
      end
      @final_table_data_total = []
      @final_table_data_total = calculate_total_of_each_section(@final_table_data_total, @floorInfo)

      @final_table_data = []
      @floorInfo.each do |resultInfo|
        @damperTotal = resultInfo["Pass"] + resultInfo["Fail"] + resultInfo["NA"]
        @damperGrandtotal = $ptotal + $ftotal + $natotal

        @damperPer = @damperGrandtotal == 0 ? @damperPer = '0.00%' : '%.2f%' % ((100 * @damperTotal) / (@damperGrandtotal))

        @final_table_data << [resultInfo["floor"], resultInfo["FD"], resultInfo["SD"], resultInfo["FSD"], resultInfo["Pass"], resultInfo["Fail"], resultInfo["NA"],  resultInfo["Pass"] + resultInfo["Fail"] + resultInfo["NA"], @damperPer]
      end

      $ptotal_damperPer  = '%.2f%' %  (($ptotal.to_f * 100) / ($ptotal + $ftotal + $natotal))
      $ftotal_damperPer  = '%.2f%' %  (($ftotal.to_f * 100) / ($ptotal + $ftotal + $natotal))
      $natotal_damperPer = '%.2f%' %  (($natotal.to_f * 100) / ($ptotal + $ftotal + $natotal))

      @final_table_data + [['GRAND TOTAL'] + @final_table_data_total]
    end
    
     def calculate_non_integer_floor_values(building_floors, building_other_floors, floor_data, key)
      if building_floors & building_other_floors == []
          if  key[1] == "other"
              building_result = Lsspdfasset.select(:u_building, :u_other_floor, :u_status).where(:u_service_id => @owner.u_service_id, :u_building => @building, :u_other_floor => key[3], :u_delete => false).where.not(u_type: "").group(["u_building", "u_other_floor", "u_status"]).count(:u_status)
            else
              building_result = Lsspdfasset.select(:u_building, :u_floor, :u_status).where(:u_service_id => @owner.u_service_id, :u_building => @building, :u_floor => key[1], :u_delete => false).where.not(u_type: "").group(["u_building", "u_floor", "u_status"]).count(:u_status)
            end
          else
            common_floors = building_floors & building_other_floors
            if common_floors.include?(floor_data)
            building_other_floor_result = Lsspdfasset.select(:u_building, :u_other_floor, :u_status).where(:u_service_id => @owner.u_service_id, :u_building => @building, :u_other_floor => floor_data, :u_delete => false).where.not(u_type: "")
                building_floor_result = Lsspdfasset.select(:u_building, :u_floor, :u_status).where(:u_service_id => @owner.u_service_id, :u_building => @building, :u_floor => floor_data, :u_delete => false).where.not(u_type: "")
               temp_result, temp_hash, type  =  building_floor_result.as_json, {}, "u_status"
               temp_hash = create_temp_hash_for_calculating_total_assets_in_the_building(temp_hash, building_other_floor_result, type)
               temp_result << temp_hash
               building_result = Hash[temp_result.group_by{|obj| obj["u_status"] || obj[:u_status]}.map{|k,v| [k,v.size]}]
            else
                building_result = Lsspdfasset.select(:u_building, :u_floor, :u_status).where(:u_service_id => @owner.u_service_id, :u_building => @building, :u_floor => key[1], :u_delete => false).where.not(u_type: "").group(["u_building", "u_floor", "u_status"]).count(:u_status)
            end
         end
         building_result
    end

      def for_type_calculate_non_integer_floor_values(building_floors, building_other_floors, floor_data, floor_json, key, value, buildingInfo)
        if building_floors & building_other_floors == []
	     #  floor_details = 	Lsspdfasset.select(:u_building, :u_floor, :u_type, :u_other_floor).where(:u_service_id => @owner.u_service_id, :u_building => @building, :u_floor => floor_data, :u_delete => false).where.not(u_type: "").group(["u_building", "u_floor", "u_type", "u_other_floor"]).order(:u_floor).count(:u_type)
             #floor_details.each do |fstatus, fvalue|
             #    if !floor_json.has_key?(fstatus[2])
             #      floor_json[fstatus[2]] = fvalue
             #    end
             #  end
	   floor_json  = update_utype(floor_json, floor_data)
         else
		 
            common_floors = building_floors & building_other_floors
            if common_floors.include?(floor_data)
            building_other_floor_result = Lsspdfasset.select(:u_building, :u_other_floor, :u_type).where(:u_service_id => @owner.u_service_id, :u_building => @building, :u_other_floor => floor_data, :u_delete => false).where.not(u_type: "")
            building_floor_result = Lsspdfasset.select(:u_building, :u_floor, :u_type).where(:u_service_id => @owner.u_service_id, :u_building => @building, :u_floor => floor_data, :u_delete => false).where.not(u_type: "")
            
	    temp_result, temp_hash, type =  building_floor_result.as_json, {}, "u_type"
            temp_hash = create_temp_hash_for_calculating_total_assets_in_the_building(temp_hash, building_other_floor_result, type)
               temp_result << temp_hash
               @building_result = Hash[temp_result.group_by{|obj| obj["u_type"] || obj[:u_type]}.map{|k,v| [k,v.size]}]

               @building_result.each do |fstatus, fvalue|
                 if !floor_json.has_key?(fstatus)
                   floor_json[fstatus] = fvalue
                 end
               end
               initialize_type_empty_columns(floor_json)
               floor_json
            else
              floor_json = update_utype(floor_json, floor_data)
            end
         end
	puts "type=================final"
	puts floor_json
	floor_json
     end

     def update_utype(floor_json, floor_data)
         floor_details =  Lsspdfasset.select(:u_building, :u_floor, :u_type, :u_other_floor).where(:u_service_id => @owner.u_service_id, :u_building => @building, :u_floor => floor_data, :u_delete => false).where.not(u_type: "").group(["u_building", "u_floor", "u_type", "u_other_floor"]).order(:u_floor).count(:u_type)
             floor_details.each do |fstatus, fvalue|
                 if !floor_json.has_key?(fstatus[2])
                   floor_json[fstatus[2]] = fvalue
                 end
               end

        #buildingInfo.each do |row, val|
#          if row[2] == "FSD"
#            floor_json["FSD"] = val
#          elsif row[2] == "FD"
#            floor_json["FD"] = val
#          else
#            floor_json["SD"] = val
#           end
        # end
	initialize_type_empty_columns(floor_json)
        floor_json
     end

     def initialize_type_empty_columns(floor_json)

        if !floor_json.has_key?("FSD")
           floor_json["FSD"] = 0
        end

        if !floor_json.has_key?("SD")
           floor_json["SD"] = 0
        end

        if !floor_json.has_key?("FD")
           floor_json["FD"] = 0
        end

        floor_json
     end

      def initialize_status_empty_columns(floor_json)
        if !floor_json.has_key?("Pass")
           floor_json["Pass"] = 0
        end

        if !floor_json.has_key?("Fail")
           floor_json["Fail"] = 0
        end

        if !floor_json.has_key?("NA")
           floor_json["NA"] = 0
        end

      end

     def calculate_total_of_each_section(final_table_data_total, floorInfo)
       $fsdtotal = 0
       $fdtotal = 0
       $sdtotal = 0
       $ptotal = 0
       $ftotal = 0
       $natotal = 0
       $rtotal = 0

      floorInfo.each do |totalInfo|
        $fsdtotal += totalInfo["FSD"]
        $fdtotal += totalInfo["FD"]
        $sdtotal += totalInfo["SD"]
        $ptotal += totalInfo["Pass"]
        $ftotal += totalInfo["Fail"]
        $natotal += totalInfo["NA"]
      end

      final_table_data_total.push($fdtotal)
      final_table_data_total.push($sdtotal)
      final_table_data_total.push($fsdtotal)
      final_table_data_total.push($ptotal)
      final_table_data_total.push($ftotal)
      final_table_data_total.push($natotal)
      final_table_data_total.push($sdtotal + $fdtotal + $fsdtotal)
      final_table_data_total.push("100.00%")
      final_table_data_total
    end

    def create_temp_hash_for_calculating_total_assets_in_the_building(temp_hash, building_other_floor_result, type)
       temp_hash[:id] = ""
       temp_hash[:u_building] = building_other_floor_result.first.u_building
       temp_hash[:u_floor] = building_other_floor_result.first.u_other_floor
       if type == "u_type"
         temp_hash[:u_type] = building_other_floor_result.first.u_type
       elsif type == "u_status"
         temp_hash[:u_status] = building_other_floor_result.first.u_status
       end
       temp_hash
    end

    def initialize_floor_json(floorInfo,floor_json, key, value, building_floors, building_other_floors, buildingInfo)
     floor_json["building"] = key[0]
     floor_data = key[1] == "other" ? key[3] : key[1]
     floor_json["floor"] = floor_data
     floor_json = for_type_calculate_non_integer_floor_values(building_floors, building_other_floors, floor_data, floor_json, key, value, buildingInfo)
     building_result = calculate_non_integer_floor_values(building_floors, building_other_floors, floor_data, key)
     building_result.each do |fstatus, fvalue|
       if fstatus.class == String
         if !floor_json.has_key?(fstatus)
            floor_json[fstatus] = fvalue
         end
       else
         if !floor_json.has_key?(fstatus[2])
           floor_json[fstatus[2]] = fvalue
         end
       end
     end
     initialize_status_empty_columns(floor_json)
     initialize_type_empty_columns(floor_json)
     floorInfo.push(floor_json)
     floorInfo
    end
   
    # end new code
    def result_table_content
      [[DamperInspectionReporting.column_heading(:test_result),
       DamperInspectionReporting.column_heading(:percent_of_dampers)]] + 
       [[DamperInspectionReporting.column_heading(:pass), $ptotal_damperPer],
       [DamperInspectionReporting.column_heading(:fail), $ftotal_damperPer],
       [DamperInspectionReporting.column_heading(:na), $natotal_damperPer]
      # [DamperInspectionReporting.column_heading(:removed), $rtotal]
      ]
    end

    def type_table_content
      [[DamperInspectionReporting.column_heading(:type),
        DamperInspectionReporting.column_heading(:total),
        DamperInspectionReporting.column_heading(:percent_of_dampers)]] + 
        [["Smoke Damper", $sdtotal, '%.2f%' % (($sdtotal.to_f * 100) / ($ptotal + $ftotal + $natotal))],
         ["Fire Damper", $fdtotal, '%.2f%' % (($fdtotal.to_f * 100) / ($ptotal + $ftotal + $natotal))],
         ["Fire/Smoke Damper", $fsdtotal, '%.2f%' % (($fsdtotal.to_f * 100) / ($ptotal + $ftotal + $natotal))]
        ]
    end
  end
end
