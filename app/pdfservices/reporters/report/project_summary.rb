module Report
  class ProjectSummary
  	#include SummaryDrawable

    def initialize(owner)
      @owner = owner
    end

    def draw(pdf)
      draw_facility_title(pdf)
      Report::Table.new(facility_summary_table_content).draw(pdf)
      pdf.move_down 30
      draw_title(pdf)
      Report::Table.new(project_summary_table_content).draw(pdf)
      pdf.move_down 30
      draw_label(pdf, 'Statistics')
      top = pdf.cursor
      # pdf.indent(300) { Report::Table.new(type_table_content).draw(pdf) }
      pdf.move_cursor_to top
      Report::Table.new(project_statistics_data).draw(pdf) do |formatter|
        formatter.cell[1,0] = { :text_color => '137d08' }
        formatter.cell[2,0] = { :text_color => 'c1171d' }
        formatter.cell[3,0] = { :text_color => 'f39d27' }
      end
      pdf.move_down 25
    end
   
  private

    def building ; end

    def draw_facility_title(pdf)
      pdf.font_size 40
      pdf.fill_color 'f39d27'
      pdf.text("<b>Facility Building Summary</b>", :inline_format => true)
      pdf.fill_color '202020'
      pdf.move_down 10
    end  

    def draw_title(pdf)
      pdf.font_size 40
      pdf.fill_color 'f39d27'
      pdf.text("<b>#{I18n.t('pdf.summary_page.project_summary')}</b>", :inline_format => true)
      pdf.fill_color '202020'
      pdf.move_down 10
    end

    def draw_label(pdf, text)
      pdf.font_size 15
      pdf.fill_color 'f39d27'
      pdf.text("<b>#{text}</b>", :inline_format => true)
      pdf.fill_color '202020'
      pdf.move_down 10
    end

    def project_summary_table_headings
      ["Building", "Type", "Pass", "Fail", "Non-Accessible", "Total", "% of Total"]
    end

    def project_summary_table_content
      [project_summary_table_headings] + project_summary_table_data
    end

    def project_summary_table_data
      @serviceInfo = Lsspdfasset.select(:u_building, :u_type, :u_status).where(:u_service_id => @owner.u_service_id, :u_delete => false).where("u_status !=?", "Removed").group(["u_building", "u_type","u_status"]).count(:u_status)
      @buildingInfo = []
      @serviceInfo.each do |key,value|
        building_json = {}
        if @buildingInfo.length == 0
          building_json["building"] = key[0]
          if key[1] == "FSD"
            building_json["type"] = "FSD"
          elsif key[1] == "FD"
             building_json["type"] = "FD"
          else
            building_json["type"] = "SD"
          end
          if key[2] == "Pass"
              building_json["Pass"] = value
              building_json["Fail"] = 0
              building_json["NA"] = 0
            elsif key[2] == "Fail"
              building_json["Pass"] = 0
              building_json["Fail"] = value
              building_json["NA"] = 0
            else
              building_json["Pass"] = 0
              building_json["Fail"] = 0
              building_json["NA"] = value
          end
          @buildingInfo.push(building_json)
        else
          @boolean = 0
          @buildingInfo.each do |info|
            if (info.has_value?(key[0]) && info.has_value?(key[1]))
              if (key[2]  == "Pass")
                info["Pass"] = value
              elsif (key[2]  == "Fail")
                info["Fail"] = value
              else
                info["NA"] = value
              end
             @boolean = 1
            end
          end
          if @boolean == 0
            building_json["building"] = key[0]
            if key[1] == "FSD"
              building_json["type"] = "FSD"
            elsif key[1] == "FD"
              building_json["type"] = "FD"
            else
              building_json["type"] = "SD"
            end

            if key[2] == "Pass"
              building_json["Pass"] = value
              building_json["Fail"] = 0
              building_json["NA"] = 0
            elsif key[2] == "Fail"
              building_json["Pass"] = 0
              building_json["Fail"] = value
              building_json["NA"] = 0
            else
              building_json["Pass"] = 0
              building_json["Fail"] = 0
              building_json["NA"] = value
            end
            @buildingInfo.push(building_json)
          end
        end
      end
      
      @project_grand_total_data = []
      $ptotal = 0
      $ftotal = 0
      $natotal = 0      
      @buildingInfo.each do |totalInfo|
        $ptotal += totalInfo["Pass"]
        $ftotal += totalInfo["Fail"]
        $natotal += totalInfo["NA"]
      end
      @project_grand_total_data.push($ptotal)
      @project_grand_total_data.push($ftotal)
      @project_grand_total_data.push($natotal)
      @project_grand_total_data.push($ptotal + $ftotal + $natotal)
      #@project_grand_total_data.push('%.2f%' % (($ptotal.to_f * 100) / ($ptotal + $ftotal + $natotal)))

      @project_final_table_data = []
      @buildingInfo.each do |resultInfo|
        if resultInfo["type"] == "FSD"
          @damper_type = "Fire/Smoke Damper"
        elsif resultInfo["type"] == "FD"
          @damper_type = "Fire Damper"
        else
          @damper_type = "Smoke Damper"
        end        
        @project_total = resultInfo["Pass"] + resultInfo["Fail"] + resultInfo["NA"]
        @project_grand_total = $ptotal + $ftotal + $natotal
        @project_per = '%.2f%' % ((100 * @project_total.to_f) / (@project_grand_total))
        @project_final_table_data << [resultInfo["building"], @damper_type, resultInfo["Pass"], resultInfo["Fail"], resultInfo["NA"], @project_total, @project_per]
      end

      # @project_grand_total_data = []
      # $ptotal = 0
      # $ftotal = 0
      # $natotal = 0
      # @buildingInfo.each do |totalInfo|
      #   $ptotal += totalInfo["Pass"]
      #   $ftotal += totalInfo["Fail"]
      #   $natotal += totalInfo["NA"]
      # end
      # @project_grand_total_data.push($ptotal)
      # @project_grand_total_data.push($ftotal)
      # @project_grand_total_data.push($natotal)
      # @project_grand_total_data.push($ptotal + $ftotal + $natotal)
      # @project_grand_total_data.push('%.2f%' % (($ptotal.to_f * 100) / ($ptotal + $ftotal + $natotal)))

      @project_grand_total_data.push("100.00%")
      $project_pass_per  = '%.2f%' %  (($ptotal.to_f * 100) / ($ptotal + $ftotal + $natotal))
      $project_fail_per  = '%.2f%' %  (($ftotal.to_f * 100) / ($ptotal + $ftotal + $natotal))
      $project_na_per = '%.2f%' %  (($natotal.to_f * 100) / ($ptotal + $ftotal + $natotal))

      @project_final_table_data + [['GRAND TOTAL', ''] + @project_grand_total_data]
    end

    def project_statistics_data
      [[DamperInspectionReporting.column_heading(:test_result),
       DamperInspectionReporting.column_heading(:percent_of_dampers)]] + 
       [[DamperInspectionReporting.column_heading(:pass), $project_pass_per],
       [DamperInspectionReporting.column_heading(:fail), $project_fail_per],
       [DamperInspectionReporting.column_heading(:na), $project_na_per]]
    end

    def facility_summary_table_headings
      ["Building", "Pass", "Fail", "Non-Accessible", "Total", "% of Total"] 
    end

    def facility_summary_table_content
      [facility_summary_table_headings] +  facility_summary_table_data
    end

    def facility_summary_table_data
      @facility_serviceInfo = Lsspdfasset.select(:u_building, :u_status).where(:u_service_id => @owner.u_service_id, :u_delete => false).where("u_status !=?", "Removed").group(["u_building", "u_status"]).count(:u_status)
      @facility_buildingInfo = []
      
      @facility_serviceInfo.each do |key,value|
        facility_building_json = {}
        if @facility_buildingInfo.length == 0
          facility_building_json["building"] = key[0]
          if key[1] == "Pass"
            facility_building_json["Pass"] = value
            facility_building_json["Fail"] = 0
            facility_building_json["NA"] = 0            
          elsif key[1] == "Fail"
            facility_building_json["Pass"] = 0
            facility_building_json["Fail"] = value
            facility_building_json["NA"] = 0
          else
            facility_building_json["Pass"] = 0
            facility_building_json["Fail"] = 0
            facility_building_json["NA"] = value
          end
          @facility_buildingInfo.push(facility_building_json)
        else
          @boolean = 0
          @facility_buildingInfo.each do |info|            
            if (info.has_value?(key[0]))              
              info[key[1]] = value
              @boolean = 1
            end
          end
          if @boolean == 0
            facility_building_json["building"] = key[0]
            
            if key[1] == "Pass"
              facility_building_json["Pass"] = value
              facility_building_json["Fail"] = 0
              facility_building_json["NA"] = 0            
            elsif key[1] == "Fail"
              facility_building_json["Pass"] = 0
              facility_building_json["Fail"] = value
              facility_building_json["NA"] = 0
            else
              facility_building_json["Pass"] = 0
              facility_building_json["Fail"] = 0
              facility_building_json["NA"] = value
            end            
            @facility_buildingInfo.push(facility_building_json)
          end
        end  
      end

      @facility_grand_total_data = []
      $bptotal = 0
      $bftotal = 0
      $bnatotal = 0
      @facility_buildingInfo.each do |totalInfo|
        $bptotal += totalInfo["Pass"]
        $bftotal += totalInfo["Fail"]
        $bnatotal += totalInfo["NA"]
      end
      @facility_grand_total_data.push($bptotal)
      @facility_grand_total_data.push($bftotal)
      @facility_grand_total_data.push($bnatotal)

      @facility_grand_total_data.push($bptotal + $bftotal + $bnatotal)
      @facility_grand_total_data.push("100.00%")


      @facility_building_table_data = []
      @facility_buildingInfo.each do |facilityvalue|

        @facility_total = facilityvalue["Pass"] + facilityvalue["Fail"] + facilityvalue["NA"]
        @facility_grand_total = $bptotal + $bftotal + $bnatotal
        @facility_per = '%.2f%' % ((100 * @facility_total.to_f) / (@facility_grand_total))

        @facility_building_table_data << [facilityvalue["building"], facilityvalue["Pass"], facilityvalue["Fail"], facilityvalue["NA"], @facility_total, @facility_per]
      end
      
      # @facility_grand_total_data = []
      # $bptotal = 0
      # $bftotal = 0
      # $bnatotal = 0
      # @facility_buildingInfo.each do |totalInfo|
      #   $bptotal += totalInfo["Pass"]
      #   $bftotal += totalInfo["Fail"]
      #   $bnatotal += totalInfo["NA"]
      # end
      # @facility_grand_total_data.push($bptotal)
      # @facility_grand_total_data.push($bftotal)
      # @facility_grand_total_data.push($bnatotal)

      # @facility_grand_total_data.push($bptotal + $bftotal + $bnatotal)
      # @facility_grand_total_data.push('%.2f%' % (($bptotal.to_f * 100) / ($bptotal + $bftotal + $bnatotal)))

      @facility_building_table_data + [['GRAND TOTAL'] + @facility_grand_total_data]      
    end 
  end
end