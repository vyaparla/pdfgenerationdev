module Report
  module SummaryDrawable

  	def draw(pdf)
      draw_title(pdf, title)
      Report::Table.new(summary_table_content).draw(pdf)
      pdf.move_down 30
      draw_label(pdf, 'Statistics')
      top = pdf.cursor
      #pdf.indent(300) { Report::Table.new(type_table_content).draw(pdf) }
      pdf.move_cursor_to top
      Report::Table.new(result_table_content).draw(pdf) do |formatter|
        formatter.cell[1,0] = { :text_color => '137d08' }
        formatter.cell[2,0] = { :text_color => 'c1171d' }
        formatter.cell[3,0] = { :text_color => 'f39d27' }
      end
      pdf.move_down 60
      #Report::Table.new(overview_table_content).draw(pdf)
    end

  private
  
    def column_heading(key)
      I18n.t("ui.inspection_report_pdf.table_headings_cols.#{key}")
    end
   
    def draw_label(pdf, text)
      pdf.font_size 15
      pdf.fill_color 'f39d27'
      pdf.text("<b>#{text}</b>", :inline_format => true)
      pdf.fill_color '202020'
      pdf.move_down 10
    end

    def draw_title(pdf, title)
      pdf.font_size 25
      pdf.fill_color 'f39d27'
      pdf.text("<b>#{title} - #{@building}</b>", :inline_format => true)
      pdf.fill_color '202020'
      pdf.move_down 10
    end

    def table_column_headings(heading)
      # [column_heading(heading)] +
      # @owner.damper_types.map { |type| Damper.damper_types[type].capitalize } +
      # %i(pass fail na total_dampers).map { |k| column_heading(k) }
      [column_heading(heading)] +
      ["Fire", "Somke", "Combination"] +
      %i(pass fail na removed total_dampers damper_per).map { |k| column_heading(k)}
    end

    def summary_table_content
      [summary_table_headings] + summary_table_data
    end

    def summary_table_data
      #[["1", "5", "5", "5", "5", "5", "5"], ["2", "5", "5", "5", "5", "5", "5"]]
      #@building.floors.map { |f,| summary_table_row(f) 
      @buildingInfo = Lsspdfasset.select(:u_building, :u_floor, :u_type).where(:u_service_id => @owner.u_service_id, :u_building => @building, :u_delete => false ).where.not(u_type: "").group(["u_building", "u_floor", "u_type"]).order(:u_floor).count(:u_type)
      @floorInfo = []
      @buildingInfo.each do |key,value|
        floor_json = {}
        if @floorInfo.length == 0
          
          floor_json["building"] = key[0]
          floor_json["floor"] = key[1].to_i

          if key[2] == "FSD"
            floor_json["FSD"] = value
            floor_json["FD"] = 0
            floor_json["SD"] = 0
          elsif key[2] == "FD"
            floor_json["FSD"] = 0
            floor_json["FD"] = value
            floor_json["SD"] = 0
          else
            floor_json["FSD"] = 0
            floor_json["FD"] = 0
            floor_json["SD"] = value
          end
          @building_result = Lsspdfasset.select(:u_building, :u_floor, :u_status).where(:u_service_id => @owner.u_service_id, :u_building => @building, :u_floor => key[1], :u_delete => false).where.not(u_type: "").group(["u_building", "u_floor", "u_status"]).count(:u_status)

          @building_result.each do |fstatus, fvalue|
            if !floor_json.has_key?(fstatus[2])
              floor_json[fstatus[2]] = fvalue
            end
          end

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
          
          @floorInfo.push(floor_json)
        else
          @boolean = 0
          @floorInfo.each do |info|
            @damperType = key[2]
            if info.has_key?(key[2])
              if info["floor"] == key[1].to_i
                info[key[2]] = value
                @boolean = 1
              end
            end
          end

          if @boolean == 0
            #floor_json = {}
            floor_json["building"] = key[0]
            floor_json["floor"] = key[1].to_i
            if key[2] == "FSD"
              floor_json["FSD"] = value
              floor_json["FD"] = 0
              floor_json["SD"] = 0
            elsif key[2] == "FD"
              floor_json["FSD"] = 0
              floor_json["FD"] = value
              floor_json["SD"] = 0
            else
              floor_json["FSD"] = 0
              floor_json["FD"] = 0
              floor_json["SD"] = value
            end
            
            #@building_result = Lsspdfasset.select(:u_building, :u_floor, :u_status).where(:u_service_id => @owner.u_service_id, :u_building => @building, :u_floor => key[1], :u_delete => false).where("u_status !=?", "Removed").group(["u_building", "u_floor", "u_status"]).count(:u_status)
            @building_result = Lsspdfasset.select(:u_building, :u_floor, :u_status).where(:u_service_id => @owner.u_service_id, :u_building => @building, :u_floor => key[1], :u_delete => false).group(["u_building", "u_floor", "u_status"]).count(:u_status)
            @building_result_len =  @building_result.length
    
            @building_result.each do |fstatus, fvalue|
             if !floor_json.has_key?(fstatus[2])
               floor_json[fstatus[2]] = fvalue
              end
            end

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

            @floorInfo.push(floor_json)
          end
        end
      end
      
      @final_table_data_total = []
      $fsdtotal = 0
      $fdtotal = 0
      $sdtotal = 0
      $ptotal = 0
      $ftotal = 0
      $natotal = 0
      $rtotal = 0

      @floorInfo.each do |totalInfo|
        $fsdtotal += totalInfo["FSD"]        
        $fdtotal += totalInfo["FD"]
        $sdtotal += totalInfo["SD"]
        $ptotal += totalInfo["Pass"]
        $ftotal += totalInfo["Fail"]
        $natotal += totalInfo["NA"]
        $rtotal += totalInfo["Removed"]
      end
      
      @final_table_data_total.push($fdtotal)
      @final_table_data_total.push($sdtotal)      
      @final_table_data_total.push($fsdtotal)
      @final_table_data_total.push($ptotal)
      @final_table_data_total.push($ftotal)
      @final_table_data_total.push($natotal)
      @final_table_data_total.push($rtotal)
      #@final_table_data_total.push("0")
      #@final_table_data_total.push($sdtotal + $fdtotal + $fsdtotal)
      @final_table_data_total.push($ptotal + $ftotal + $natotal)

      if $ptotal == 0 && $ftotal == 0 && $natotal == 0
        @final_table_data_total.push("00.00%")
      else
        @final_table_data_total.push("100.00%")
      end   
      
      Rails.logger.debug("Floor Info :#{@floorInfo.inspect}")

      @final_table_data = []
      @floorInfo.each do |resultInfo|
        @damperTotal = resultInfo["Pass"] + resultInfo["Fail"] + resultInfo["NA"]
        @damperGrandtotal = $ptotal + $ftotal + $natotal

        if @damperTotal == 0 && @damperGrandtotal == 0
          @damperPer = "00.00%"
        else
          @damperPer = '%.2f%' % ((100 * @damperTotal) / (@damperGrandtotal))
        end        
        #@damperPer = '%.2f%' % ((resultInfo["Pass"] * 100) / (resultInfo["FSD"] + resultInfo["FD"] + resultInfo["SD"]))
        #@final_table_data << [resultInfo["floor"], resultInfo["FD"], resultInfo["SD"], resultInfo["FSD"], resultInfo["Pass"], resultInfo["Fail"], resultInfo["NA"], resultInfo["Removed"], resultInfo["Pass"] + resultInfo["Fail"] + resultInfo["NA"] + resultInfo["Removed"], @damperPer]
        @final_table_data << [resultInfo["floor"], resultInfo["FD"], resultInfo["SD"], resultInfo["FSD"], resultInfo["Pass"], resultInfo["Fail"], resultInfo["NA"], resultInfo["Removed"], resultInfo["Pass"] + resultInfo["Fail"] + resultInfo["NA"], @damperPer]
      end
    
      # @final_table_data_total = []
      # $fsdtotal = 0
      # $fdtotal = 0
      # $sdtotal = 0
      # $ptotal = 0
      # $ftotal = 0
      # $natotal = 0

      # @floorInfo.each do |totalInfo|        
      #   $fsdtotal += totalInfo["FSD"]        
      #   $fdtotal += totalInfo["FD"]
      #   $sdtotal += totalInfo["SD"]
      #   $ptotal += totalInfo["Pass"]
      #   $ftotal += totalInfo["Fail"]
      #   $natotal += totalInfo["NA"]
      # end
 
      # @final_table_data_total.push($fsdtotal)
      # @final_table_data_total.push($fdtotal)
      # @final_table_data_total.push($sdtotal)
      # @final_table_data_total.push($ptotal)
      # @final_table_data_total.push($ftotal)
      # @final_table_data_total.push($natotal)
      # @final_table_data_total.push($fsdtotal + $fdtotal + $sdtotal)

      if $ptotal == 0 && $ftotal == 0 && $natotal == 0
        $ptotal_damperPer  = "00.00%"
        $ftotal_damperPer  = "00.00%"
        $natotal_damperPer = "00.00%"
      else
        $ptotal_damperPer  = '%.2f%' %  (($ptotal.to_f * 100) / ($ptotal + $ftotal + $natotal))
        $ftotal_damperPer  = '%.2f%' %  (($ftotal.to_f * 100) / ($ptotal + $ftotal + $natotal))
        $natotal_damperPer = '%.2f%' %  (($natotal.to_f * 100) / ($ptotal + $ftotal + $natotal))
      end

      #@final_table_data_total.push($ptotal_damperPer)
      @final_table_data + [['GRAND TOTAL'] + @final_table_data_total]
      #Rails.logger.debug("Floor Final Result : #{@final_table_data.inspect}")
    end

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

    def result_table_content
      [[DamperInspectionReporting.column_heading(:test_result),
       DamperInspectionReporting.column_heading(:percent_of_dampers)]] + 
       [[DamperInspectionReporting.column_heading(:pass), $ptotal_damperPer],
       [DamperInspectionReporting.column_heading(:fail), $ftotal_damperPer],
       [DamperInspectionReporting.column_heading(:na), $natotal_damperPer],
       [DamperInspectionReporting.column_heading(:removed), $rtotal]
       #[DamperInspectionReporting.column_heading(:removed), "00.00%"]
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