module DamperStatementReport
    class ProjectSummaryPage
    include Report::ComprehensiveDataPageWritable

    def initialize(job, tech, report_type, watermark)
      @job = job
      @tech = tech
      @report_type = report_type
      @watermark = watermark
    end

    def write(pdf)
      super
      pdf.stamp_at "watermark", [100, 210]  if @watermark
      #Report::DamperStatementProjectSummary.new(@job).draw(pdf)
      summary_count = (facility_summary_table_content + project_summary_table_content + project_statistics_data).count
        puts summary_count
        if summary_count > 20 
          count_without_statistics = (facility_summary_table_content + project_summary_table_content).count
          if count_without_statistics <= 16 
            #put all 3 tables together
            summary_draw_part(pdf)
          else
            f_count = facility_summary_table_content.count
            remainings = 20 - f_count
            get_from_project_count =  project_summary_table_content.first(remainings)
            project_summary_for_new_page = project_summary_table_content.drop(remainings)

            Report::Table.new(facility_summary_table_content).draw(pdf)
            pdf.move_down 20
            draw_title(pdf)
            Report::Table.new(get_from_project_count).draw(pdf) 
            super
            pdf.stamp_at "watermark", [100, 210]  if @watermark
            if project_summary_for_new_page.count >= 1
              new_project_summary_table_content = [project_summary_table_headings] + project_summary_for_new_page
              Report::Table.new(new_project_summary_table_content).draw(pdf) 
              pdf.move_down 20
            end  
            draw_label(pdf, 'Statistics')
            top = pdf.cursor
            pdf.move_cursor_to top
            Report::Table.new(project_statistics_data).draw(pdf) do |formatter|
              formatter.cell[1,0] = { :text_color => '137d08' }
              formatter.cell[2,0] = { :text_color => 'c1171d' }
              formatter.cell[3,0] = { :text_color => 'f39d27' }
            end
            pdf.move_down 20
            #facility and summary table in first page Statistics in new page  2
          end  
        else
         summary_draw_part(pdf)  
        end
      end   

    def summary_draw_part(pdf)
      draw_facility_title(pdf)
      Report::Table.new(facility_summary_table_content).draw(pdf)
      pdf.move_down 20
      draw_title(pdf)
      #project_summary_table(pdf)
      Report::Table.new(project_summary_table_content).draw(pdf) 
      pdf.move_down 20
      draw_label(pdf, 'Statistics')
      top = pdf.cursor
      pdf.move_cursor_to top
      #pdf.bounding_box([400, 310], :width => 230, :height => 420) do   
        Report::Table.new(project_statistics_data).draw(pdf) do |formatter|
          formatter.cell[1,0] = { :text_color => '137d08' }
          formatter.cell[2,0] = { :text_color => 'c1171d' }
          formatter.cell[3,0] = { :text_color => 'f39d27' }
      #  end
      end 
      pdf.move_down 20
    end
   
  private

    def building ; end

    def project_summary_table(pdf)
      pdf.font_size 8
      pdf.table(project_summary_table_content, header: true) do |table|
        table.row(0).style background_color: '444444', text_color: 'ffffff'
        table.rows(0).style {|r| r.border_color = '888888'}
        #table.row_colors = ['ffffff', 'eaeaea']
        table.rows(0...table.row_length).style border_width: 0.5
        table.row(0).style border_color:     '888888',
                         background_color: '444444',
                         text_color:       'ffffff'
        table.rows(1...table.row_length).style border_color: 'cccccc'
        table.column(0).style {|c| c.width = 100 }
      end
    end 

    def draw_facility_title(pdf)
      pdf.font_size 30
      pdf.fill_color 'ED1C24'
      pdf.text("<b>Facility Building Summary</b>", :inline_format => true)
      pdf.fill_color '202020'
      pdf.move_down 10
    end

    def draw_title(pdf)
      pdf.font_size 30
      pdf.fill_color 'ED1C24'
      pdf.text("<b>#{I18n.t('pdf.summary_page.project_summary')}</b>", :inline_format => true)
      pdf.fill_color '202020'
      pdf.move_down 10
    end

    def draw_label(pdf, text)
      pdf.font_size 20
      pdf.fill_color 'ED1C24'
      pdf.text("<b>#{text}</b>", :inline_format => true)
      #pdf.draw_text("#{text}", :style => :bold, :inline_format => true, at: [420 , 320])
      pdf.fill_color '202020'
      pdf.move_down 10
    end

    def project_summary_table_headings
      ["Building", "Type", "Pass", "Fail", "Non-Accessible", "Total", "% of Total", "Removed"]
    end

    def project_summary_table_content
      [project_summary_table_headings] + project_summary_table_data
    end

    def project_summary_table_data
      #@serviceInfo = Lsspdfasset.select(:u_building, :u_type, :u_status).where(:u_service_id => @job.u_service_id, :u_delete => false).where("u_status !=?", "Removed").group(["u_building", "u_type","u_status"]).count(:u_status)
      #@serviceInfo = Lsspdfasset.select(:u_building, :u_type, :u_status).where(:u_facility_id => @job.u_facility_id, :u_report_type => ["DAMPERREPAIR" ,"DAMPERINSPECTION"], :u_delete => false).where.not(u_type: "").group(["u_building", "u_type","u_status"]).order("CASE WHEN u_type = 'FD' THEN '1' WHEN u_type = 'SD' THEN '2' ELSE '3' END").count(:u_status)

     # repair_records = find_uniq_assets(@job, "DAMPERREPAIR")
     # inspection_records = find_uniq_assets(@job, "DAMPERINSPECTION")

      report_type = ["DAMPERREPAIR" ,"DAMPERINSPECTION"]
      repair_ids = @job.unique_statement_records(@job.u_facility_id, report_type)

     @damper_repair = Lsspdfasset.select(:u_building, :u_type, :u_dr_passed_post_repair).where(id: repair_ids, u_report_type: "DAMPERREPAIR").group(["u_building", "u_type","u_dr_passed_post_repair"]).order("CASE WHEN u_type = 'FD' THEN '1' WHEN u_type = 'SD' THEN '2' ELSE '3' END").count(:u_dr_passed_post_repair)
     @damper_inspection = Lsspdfasset.select(:u_building, :u_type, :u_status).where(id: repair_ids, u_report_type: "DAMPERINSPECTION").group(["u_building", "u_type","u_status"]).order("CASE WHEN u_type = 'FD' THEN '1' WHEN u_type = 'SD' THEN '2' ELSE '3' END").count(:u_status)

      new_array = @damper_repair.to_a + @damper_inspection.to_a
      status_counts = new_array.group_by{|i| i[0]}.map{|k,v| [k, v.map(&:last).sum] } 
     
      @serviceInfo = (status_counts.sort).to_h

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
            building_json["Removed"] = 0
          elsif key[2] == "Fail"
            building_json["Pass"] = 0
            building_json["Fail"] = value
            building_json["NA"] = 0
            building_json["Removed"] = 0
          elsif key[2] == "NA"
            building_json["Pass"] = 0
            building_json["Fail"] = 0
            building_json["NA"] = value
            building_json["Removed"] = 0
          else
            building_json["Pass"] = 0
            building_json["Fail"] = 0
            building_json["NA"] = 0
            building_json["Removed"] = value
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
              elsif (key[2] == "NA")
                info["NA"] = value
              else
                info["Removed"] = value
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
              building_json["Removed"] = 0
            elsif key[2] == "Fail"
              building_json["Pass"] = 0
              building_json["Fail"] = value
              building_json["NA"] = 0
              building_json["Removed"] = 0
            elsif key[2] == "NA"
              building_json["Pass"] = 0
              building_json["Fail"] = 0
              building_json["NA"] = value
              building_json["Removed"] = 0
            else
              building_json["Pass"] = 0
              building_json["Fail"] = 0
              building_json["NA"] = 0
              building_json["Removed"] =  value
            end
            @buildingInfo.push(building_json)
          end
        end
      end
      
      @project_grand_total_data = []
      $ptotal = 0
      $ftotal = 0
      $natotal = 0
      $removedtotal = 0
      @buildingInfo.each do |totalInfo|
        $ptotal += totalInfo["Pass"]
        $ftotal += totalInfo["Fail"]
        $natotal += totalInfo["NA"]
        $removedtotal += totalInfo["Removed"]
      end
      @project_grand_total_data.push($ptotal)
      @project_grand_total_data.push($ftotal)
      @project_grand_total_data.push($natotal)
      #@project_grand_total_data.push($removedtotal)
      #@project_grand_total_data.push("0")

      #@project_grand_total_data.push($ptotal + $ftotal + $natotal + $removedtotal)
      @project_grand_total_data.push($ptotal + $ftotal + $natotal)

      #@project_grand_total_data.push('%.2f%' % (($ptotal.to_f * 100) / ($ptotal + $ftotal + $natotal)))

      if $ptotal == 0 && $ftotal == 0 && $natotal == 0
        @project_grand_total_data.push("00.00%")  
      else
        @project_grand_total_data.push("100.00%")
      end
      @project_grand_total_data.push($removedtotal)

      @project_final_table_data = []
      @buildingInfo.each do |resultInfo|
        if resultInfo["type"] == "FSD"
          @damper_type = "Combination"
        elsif resultInfo["type"] == "FD"
          @damper_type = "Fire"
        else
          @damper_type = "Smoke"
        end

        @project_total = resultInfo["Pass"] + resultInfo["Fail"] + resultInfo["NA"]
        @project_grand_total = $ptotal + $ftotal + $natotal

        if @project_total == 0 && @project_grand_total == 0
          @project_per = "00.00%"   
        else
          @project_per = '%.2f%' % ((100 * @project_total.to_f) / (@project_grand_total))  
        end  
        #@project_per = '%.2f%' % ((100 * @project_total.to_f) / (@project_grand_total))
        #@project_final_table_data << [resultInfo["building"], @damper_type, resultInfo["Pass"], resultInfo["Fail"], resultInfo["NA"], resultInfo["Removed"], resultInfo["Pass"] + resultInfo["Fail"] + resultInfo["NA"] + resultInfo["Removed"], @project_per]
        @project_final_table_data << [resultInfo["building"], @damper_type, resultInfo["Pass"], resultInfo["Fail"], resultInfo["NA"], resultInfo["Pass"] + resultInfo["Fail"] + resultInfo["NA"], @project_per, resultInfo["Removed"]]
      end

     
      if $ptotal == 0 && $ftotal == 0 && $natotal == 0 
        $project_pass_per  = "00.00%"
        $project_fail_per  = "00.00%"
        $project_na_per = "00.00%"
        $project_removed_per = "00.00%"
      else
        $project_pass_per  = '%.2f%' %  (($ptotal.to_f * 100) / ($ptotal + $ftotal + $natotal ))
        $project_fail_per  = '%.2f%' %  (($ftotal.to_f * 100) / ($ptotal + $ftotal + $natotal ))
        $project_na_per = '%.2f%' %  (($natotal.to_f * 100) / ($ptotal + $ftotal + $natotal ))  
        $project_removed_per = '%.2f%' %  (($removedtotal.to_f * 100) / ($ptotal + $ftotal + $natotal ))
      end  
      
      @project_final_table_data + [['GRAND TOTAL', ''] + @project_grand_total_data]
    end

    def project_statistics_data
      [[DamperInspectionReporting.column_heading(:test_result),
       DamperInspectionReporting.column_heading(:percent_of_dampers)]] + 
       [[DamperInspectionReporting.column_heading(:pass), $project_pass_per],
       [DamperInspectionReporting.column_heading(:fail), $project_fail_per],
       [DamperInspectionReporting.column_heading(:na), $project_na_per]
     #  [DamperInspectionReporting.column_heading(:removed), $project_removed_per]
       #[DamperInspectionReporting.column_heading(:removed), "00.00%"]

       ]
    end

    def facility_summary_table_headings
      ["Building", "Pass", "Fail", "Non-Accessible","Total", "% of Total", "Removed"]
    end

    def facility_summary_table_content
      [facility_summary_table_headings] +  facility_summary_table_data
    end

    def facility_summary_table_data

     # repair_records = find_uniq_assets(@job, "DAMPERREPAIR")
     # inspection_records = find_uniq_assets(@job, "DAMPERINSPECTION")

      report_type = ["DAMPERREPAIR" ,"DAMPERINSPECTION"]
      repair_ids = @job.unique_statement_records(@job.u_facility_id, report_type)
      @damper_repair = Lsspdfasset.select(:u_building, :u_dr_passed_post_repair).where(:id => repair_ids, :u_report_type => "DAMPERREPAIR", :u_delete => false).where.not(u_type: "").group(["u_building", "u_dr_passed_post_repair"]).count(:u_dr_passed_post_repair)
      @damper_inspection = Lsspdfasset.select(:u_building, :u_status).where(:id => repair_ids, :u_report_type => "DAMPERINSPECTION", :u_delete => false).where.not(u_type: "").group(["u_building", "u_status"]).count(:u_status)

      new_array = @damper_repair.to_a + @damper_inspection.to_a
      status_counts = new_array.group_by{|i| i[0]}.map{|k,v| [k, v.map(&:last).sum] } 
      @facility_serviceInfo = (status_counts.sort).to_h

      @facility_buildingInfo = []
      
      @facility_serviceInfo.each do |key,value|

        facility_building_json = {}

        if @facility_buildingInfo.length == 0
          facility_building_json["building"] = key[0]
          if key[1] == "Pass"
            facility_building_json["Pass"] = value
            facility_building_json["Fail"] = 0
            facility_building_json["NA"] = 0
            facility_building_json["Removed"] = 0
          elsif key[1] == "Fail"
            facility_building_json["Pass"] = 0
            facility_building_json["Fail"] = value
            facility_building_json["NA"] = 0
            facility_building_json["Removed"] = 0
          elsif key[1] == "NA"
            facility_building_json["Pass"] = 0
            facility_building_json["Fail"] = 0
            facility_building_json["NA"] = value
            facility_building_json["Removed"] = 0
          else
            facility_building_json["Pass"] = 0
            facility_building_json["Fail"] = 0
            facility_building_json["NA"] = 0
            facility_building_json["Removed"] = value
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
              facility_building_json["Removed"] = 0
            elsif key[1] == "Fail"
              facility_building_json["Pass"] = 0
              facility_building_json["Fail"] = value
              facility_building_json["NA"] = 0
              facility_building_json["Removed"] = 0
            elsif key[1] == "NA"
              facility_building_json["Pass"] = 0
              facility_building_json["Fail"] = 0
              facility_building_json["NA"] = value
              facility_building_json["Removed"] = 0 
            else
              facility_building_json["Pass"] = 0
              facility_building_json["Fail"] = 0
              facility_building_json["NA"] = 0
              facility_building_json["Removed"] = value
            end
            @facility_buildingInfo.push(facility_building_json)
          end
        end
      end

      @facility_grand_total_data = []
      $bptotal = 0
      $bftotal = 0
      $bnatotal = 0
      $bremovetotal = 0

      @facility_buildingInfo.each do |totalInfo|
        $bptotal += totalInfo["Pass"]
        $bftotal += totalInfo["Fail"]
        $bnatotal += totalInfo["NA"]
        $bremovetotal += totalInfo["Removed"]
      end
      @facility_grand_total_data.push($bptotal)
      @facility_grand_total_data.push($bftotal)
      @facility_grand_total_data.push($bnatotal)
      #@facility_grand_total_data.push($bremovetotal)
      #@facility_grand_total_data.push("0")

      #@facility_grand_total_data.push($bptotal + $bftotal + $bnatotal + $bremovetotal)
      @facility_grand_total_data.push($bptotal + $bftotal + $bnatotal)

      if $bptotal == 0 && $bftotal == 0 && $bnatotal == 0
        @facility_grand_total_data.push("00.00%")        
      else
        @facility_grand_total_data.push("100.00%")
      end
      @facility_grand_total_data.push($bremovetotal)

      @facility_building_table_data = []
      @facility_buildingInfo.each do |facilityvalue|

        @facility_total = facilityvalue["Pass"] + facilityvalue["Fail"] + facilityvalue["NA"]
        @facility_grand_total = $bptotal + $bftotal + $bnatotal

        if @facility_total == 0 && @facility_grand_total == 0
          @facility_per = "00.00%"
        else
          @facility_per = '%.2f%' % ((100 * @facility_total.to_f) / (@facility_grand_total))
        end

        #@facility_per = '%.2f%' % ((100 * @facility_total.to_f) / (@facility_grand_total))
        #@facility_building_table_data << [facilityvalue["building"], facilityvalue["Pass"], facilityvalue["Fail"], facilityvalue["NA"], facilityvalue["Removed"], facilityvalue["Pass"] + facilityvalue["Fail"] + facilityvalue["NA"] + facilityvalue["Removed"], @facility_per]
        @facility_building_table_data << [facilityvalue["building"], facilityvalue["Pass"], facilityvalue["Fail"], facilityvalue["NA"], facilityvalue["Pass"] + facilityvalue["Fail"] + facilityvalue["NA"], @facility_per, facilityvalue["Removed"]]
      end
      @facility_building_table_data + [['GRAND TOTAL'] + @facility_grand_total_data]
    end 

    def find_uniq_assets(job, report_type)
      get_all = Lsspdfasset.select(:id, :u_tag).where(:u_facility_id => job.u_facility_id, :u_report_type => report_type, :u_delete => false).where.not(u_type: "").group(["u_building","u_tag"]).order('updated_at desc').count(:u_tag)
      repar_ids = []
      get_all.each do |key,val|
        if val > 1
         repar_ids << Lsspdfasset.select(:id).where(:u_facility_id => job.u_facility_id, :u_tag =>key, :u_report_type => report_type, :u_delete => false).where.not(u_type: "").order('updated_at desc').first
        else
         repar_ids << Lsspdfasset.select(:id).where(:u_facility_id => job.u_facility_id, :u_tag =>key, :u_report_type => report_type, :u_delete => false).where.not(u_type: "").order('updated_at desc').first
        end
      end  
     ids = repar_ids.collect(&:id)
    end
  end
end
