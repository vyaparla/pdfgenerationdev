module Report
  module DamperStatementSummaryDrawable

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
    end

  private
    
    def draw_title(pdf, title)
      pdf.font_size 30
      pdf.fill_color 'ED1C24'
      pdf.text("<b>#{title} - #{@building}</b>", :inline_format => true)
      pdf.fill_color '202020'
      pdf.move_down 10
    end

    def draw_label(pdf, text)
      pdf.font_size 20
      pdf.fill_color 'ED1C24'
      pdf.text("<b>#{text}</b>", :inline_format => true)
      pdf.fill_color '202020'
      pdf.move_down 10
    end

    def table_column_headings(heading)
      # [column_heading(heading)] +
      # @owner.damper_types.map { |type| Damper.damper_types[type].capitalize } +
      # %i(pass fail na total_dampers).map { |k| column_heading(k) }
      [column_heading(heading)] +
      ["Fire", "Smoke", "Combination"] +
      %i(pass fail na total_dampers damper_per removed).map { |k| column_heading(k)}
    end

    def column_heading(key)
      I18n.t("ui.inspection_report_pdf.table_headings_cols.#{key}")
    end

    def summary_table_content
      [summary_table_headings] + summary_table_data
    end

    #new code
    def summary_table_data

      records = find_uniq_assets(@owner.u_facility_id)

      @buildingInfo_data = Lsspdfasset.select(:u_building, :u_floor, :u_type, :u_other_floor).where(:id => records, :u_report_type => ["DAMPERREPAIR" ,"DAMPERINSPECTION"], :u_building => @building, :u_delete => false).where.not(u_type: "").group(["u_building", "u_floor", "u_type", "u_other_floor"]).count(:u_type)
      building_floors_data = Lsspdfasset.select(:u_building, :u_floor, :u_type, :u_other_floor).where(:id => records, :u_report_type => ["DAMPERREPAIR" ,"DAMPERINSPECTION"],  :u_building => @building, :u_delete => false).where.not(u_type: "").pluck(:u_floor)
      building_other_floors = Lsspdfasset.select(:u_building, :u_floor, :u_type, :u_other_floor).where(:id => records, :u_report_type => ["DAMPERREPAIR" ,"DAMPERINSPECTION"], :u_building => @building, :u_delete => false).where.not(u_type: "").order('u_other_floor ASC').pluck(:u_other_floor)

      building_info = []
      other_floor = []
      integer_floor = []
      @buildingInfo_data.each do |building|
        if building[0][1].to_i == 0
          other_floor << building
        else
          integer_floor << building              
        end 
      end
 
      integer_floor_sort = integer_floor.sort_by { |k, v| k[1].to_i }
      other_floor_sort = other_floor.sort_by { |k, v| k[1] }
      building_info =  integer_floor_sort + other_floor_sort

      @buildingInfo = building_info       
      building_floors = building_floors_data.sort_by { |k, v| k[1].to_i }

      @floorInfo = []
      @buildingInfo.each do |key,value|
        floor_json = {}
        if @floorInfo.length == 0
          initialize_floor_json(@floorInfo,floor_json, key, value, building_floors, building_other_floors, @buildingInfo, records)
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
            initialize_floor_json(@floorInfo,floor_json, key, value, building_floors, building_other_floors, @buildingInfo, records)
          end
        end
      end
      @final_table_data_total = []
      @final_table_data_total = calculate_total_of_each_section(@final_table_data_total, @floorInfo)

      @final_table_data = []
      @floorInfo.each do |resultInfo|
        @damperTotal = resultInfo["Pass"] + resultInfo["Fail"] + resultInfo["NA"]
        @damperGrandtotal = $ptotal + $ftotal + $natotal

        @damperPer = @damperGrandtotal == 0 ? @damperPer = '0.00%' : '%.2f%' % ((100 * @damperTotal.to_f) / (@damperGrandtotal))

        @final_table_data << [resultInfo["floor"], resultInfo["FD"], resultInfo["SD"], resultInfo["FSD"], resultInfo["Pass"], resultInfo["Fail"], resultInfo["NA"],  resultInfo["Pass"] + resultInfo["Fail"] + resultInfo["NA"], @damperPer, resultInfo["Removed"]]
      end

      $ptotal_damperPer  = '%.2f%' %  (($ptotal.to_f * 100) / ($ptotal + $ftotal + $natotal))
      $ftotal_damperPer  = '%.2f%' %  (($ftotal.to_f * 100) / ($ptotal + $ftotal + $natotal))
      $natotal_damperPer = '%.2f%' %  (($natotal.to_f * 100) / ($ptotal + $ftotal + $natotal))

      @final_table_data + [['GRAND TOTAL'] + @final_table_data_total]
    end
     

     def calculate_non_integer_floor_values(building_floors, building_other_floors, floor_data, key, records)
      if building_floors & building_other_floors == []
          building_result = calculate_status_when_no_common_floor_data(key, records)
          else
            common_floors = building_floors & building_other_floors 
            if common_floors.include?(floor_data)
		    building_other_floor_result_inspection = Lsspdfasset.select("u_building, u_other_floor as floor, u_status as status").where(:id => records, :u_building => @building, :u_other_floor => floor_data, :u_delete => false).where.not(u_type: "", u_status: "").group(["u_building", "u_other_floor", "u_status"]).count("u_status")
		    building_floor_result_inspection = Lsspdfasset.select("u_building, u_floor as floor, u_status as status").where(:id => records, :u_building => @building, :u_floor => floor_data, :u_delete => false).where.not(u_type: "", u_status: "").group(["u_building", "u_floor", "u_status"]).count("u_status")
               
	       
		    building_other_floor_result_repair = Lsspdfasset.select("u_building, u_other_floor as floor, u_dr_passed_post_repair as status").where(:id => records, :u_building => @building, :u_other_floor => floor_data, :u_delete => false).where.not(u_type: "", u_dr_passed_post_repair: "").group(["u_building", "u_other_floor", "u_dr_passed_post_repair"]).count("u_dr_passed_post_repair")
		    building_floor_result_repair = Lsspdfasset.select("u_building, u_floor as floor, u_dr_passed_post_repair as status").where(:id => records, :u_building => @building, :u_floor => floor_data, :u_delete => false).where.not(u_type: "", u_dr_passed_post_repair: "").group(["u_building", "u_floor", "u_dr_passed_post_repair"]).count("u_dr_passed_post_repair")
	       
	       new_inspection_ary = building_other_floor_result_inspection.to_a + building_floor_result_inspection.to_a
	       new_repair_ary =  building_other_floor_result_repair.to_a + building_floor_result_repair.to_a
	       new_ary = new_inspection_ary + new_repair_ary
	      status_counts = new_ary.group_by{|i| i[0]}.map{|k,v| [k, v.map(&:last).sum] }
          building_result = (status_counts.sort).to_h
            
            else
	      building_result = calculate_status_when_no_common_floor_data(key, records)
            end
	  
   
      	    building_result
	  end
    end
    def calculate_status_when_no_common_floor_data(key, records)
       # new
          if  key[1] == "other"
            @building_repair = Lsspdfasset.select(:u_building, :u_other_floor, :u_dr_passed_post_repair).where(:id => records, :u_building => @building, :u_other_floor => key[3], :u_delete => false).where.not(u_type: "").group(["u_building", "u_other_floor", "u_dr_passed_post_repair"]).count(:u_dr_passed_post_repair)
            @building_inspection = Lsspdfasset.select(:u_building, :u_other_floor, :u_status).where(:id => records, :u_building => @building, :u_other_floor => key[3], :u_delete => false).where.not(u_type: "").group(["u_building", "u_other_floor", "u_status"]).count(:u_status)
          else
            @building_repair = Lsspdfasset.select(:u_building, :u_floor, :u_dr_passed_post_repair).where(:id => records, :u_building => @building, :u_floor => key[1], :u_delete => false).where.not(u_type: "").group(["u_building", "u_floor", "u_dr_passed_post_repair"]).count(:u_dr_passed_post_repair)
            @building_inspection = Lsspdfasset.select(:u_building, :u_floor, :u_status).where(:id => records, :u_building => @building, :u_floor => key[1], :u_delete => false).where.not(u_type: "").group(["u_building", "u_floor", "u_status"]).count(:u_status)
          end

          new_array = @building_repair.to_a + @building_inspection.to_a
          status_counts = new_array.group_by{|i| i[0]}.map{|k,v| [k, v.map(&:last).sum] }

          buildingresult = (status_counts.sort).to_h
	  buildingresult   
     end	     

     def calculate_type_when_no_common_floor_data(key, records)
       # new
         if  key[1] == "other"
                  building_result = Lsspdfasset.select(:u_building, :u_other_floor, :u_type).where(:id => records, :u_building => @building, :u_other_floor => key[3], :u_delete => false).where.not(u_type: "").group(["u_building", "u_other_floor", "u_type"]).count(:u_type)
            else
              building_result = Lsspdfasset.select(:u_building, :u_floor, :u_type).where(:id => records, :u_building => @building, :u_floor => key[1], :u_delete => false).where.not(u_type: "").group(["u_building", "u_floor", "u_type"]).count(:u_type)
            end
           building_result
     end

    def for_type_calculate_non_integer_floor_values(building_floors, building_other_floors, floor_data, floor_json, key, value, buildingInfo, records)
        if building_floors & building_other_floors == []
           building_result = calculate_type_when_no_common_floor_data(key, records)
         else

            common_floors = building_floors & building_other_floors
            if common_floors.include?(floor_data)
            building_other_floor_result = Lsspdfasset.select(:u_building, :u_other_floor, :u_type).where(:id => records, :u_building => @building, :u_other_floor => floor_data, :u_delete => false).where.not(u_type: "")
            building_floor_result = Lsspdfasset.select(:u_building, :u_floor, :u_type).where(:id => records, :u_building => @building, :u_floor => floor_data, :u_delete => false).where.not(u_type: "")

            temp_result, temp_hash, type =  building_floor_result.as_json, {}, "u_type"
            temp_hash = create_temp_hash_for_calculating_total_assets_in_the_building(temp_hash, building_other_floor_result, type)
               temp_result << temp_hash
               @building_result = Hash[temp_result.group_by{|obj| obj["u_type"] || obj[:u_type]}.map{|k,v| [k,v.size]}]
               building_result = @building_result
             else
	       building_result = calculate_type_when_no_common_floor_data(key, records)
             end		     
            building_result
            end
        
         building_result.each do |ftype, fvalue|
           if ftype.class == String
             if !floor_json.has_key?(ftype)
               floor_json[ftype] = fvalue
             end
            else
          if !floor_json.has_key?(ftype)
           floor_json[ftype[2]] = fvalue
         end
         end
       end
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

        if !floor_json.has_key?("Removed")
           floor_json["Removed"] = 0
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
        $rtotal += totalInfo["Removed"]
      end

      final_table_data_total.push($fdtotal)
      final_table_data_total.push($sdtotal)
      final_table_data_total.push($fsdtotal)
      final_table_data_total.push($ptotal)
      final_table_data_total.push($ftotal)
      final_table_data_total.push($natotal)
      final_table_data_total.push($ptotal + $ftotal + $natotal)
      final_table_data_total.push("100.00%")
      final_table_data_total.push($rtotal)
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
       elsif type == "u_dr_passed_post_repair"
         temp_hash[:u_dr_passed_post_repair] = building_other_floor_result.first.u_dr_passed_post_repair	       
       end
       temp_hash
    end

    def initialize_floor_json(floorInfo,floor_json, key, value, building_floors, building_other_floors, buildingInfo, records)
     floor_json["building"] = key[0]
     floor_data = key[1] == "other" ? key[3] : key[1]
     floor_json["floor"] = floor_data
     floor_json = for_type_calculate_non_integer_floor_values(building_floors, building_other_floors, floor_data, floor_json, key, value, buildingInfo, records)
     building_result = calculate_non_integer_floor_values(building_floors, building_other_floors, floor_data, key, records)
     
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
    
    def result_table_content
      [[DamperInspectionReporting.column_heading(:test_result),
       DamperInspectionReporting.column_heading(:percent_of_dampers)]] + 
       [[DamperInspectionReporting.column_heading(:pass), $ptotal_damperPer],
       [DamperInspectionReporting.column_heading(:fail), $ftotal_damperPer],
       [DamperInspectionReporting.column_heading(:na), $natotal_damperPer]
      # [DamperInspectionReporting.column_heading(:removed), $rmtotal_damperPer]
      ]
    end

    def find_uniq_assets(owner)
      get_all = Lsspdfasset.select(:id, :u_tag).where(:u_facility_id => owner, :u_report_type => ["DAMPERREPAIR", "DAMPERINSPECTION"], :u_delete => false).where.not(u_type: "").group(["u_building","u_tag"]).order('u_updated_date desc').count(:u_tag)
 
      repar_ids = []
      get_all.each do |key,val|
        if val > 1
         repar_ids << Lsspdfasset.select(:id).where(:u_facility_id => owner, :u_tag =>key[1], :u_building => key[0], :u_report_type => ["DAMPERREPAIR", "DAMPERINSPECTION"], :u_delete => false).where.not(u_type: "").order('u_updated_date desc').first
        else
         repar_ids << Lsspdfasset.select(:id).where(:u_facility_id => owner, :u_tag =>key[1], :u_building => key[0], :u_report_type => ["DAMPERREPAIR", "DAMPERINSPECTION"], :u_delete => false).where.not(u_type: "").order('u_updated_date desc').first
        end
      end  
     ids = repar_ids.collect(&:id)
    end
  end
end
