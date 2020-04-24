module DamperRepairReport
  class ProjectSummaryPage
    include Report::RepairDataPageWritable

    def initialize(job, tech, watermark)
      @job = job
      @owner = job
      @tech = tech
      @watermark = watermark
    end

    def write(pdf)
      super
      pdf.stamp_at "watermark", [100, 210] if @watermark 
      #Report::ProjectSummary.new(@job).draw(pdf)

      summary_count = (dr_facility_summary_table_content + dr_project_summary_table_content + dr_project_statistics_data).count
        puts summary_count
        if summary_count > 20 
          count_without_statistics = (dr_facility_summary_table_content + dr_project_summary_table_content).count
          if count_without_statistics <= 16 
            #put all 3 tables together
            summary_page_content_draw(pdf)
          else
            f_count = dr_facility_summary_table_content.count
            remainings = 20 - f_count
            get_from_project_count =  dr_project_summary_table_content.first(remainings)
            project_summary_for_new_page = dr_project_summary_table_content.drop(remainings)

            Report::Table.new(dr_facility_summary_table_content).draw(pdf)
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
            Report::Table.new(dr_project_statistics_data).draw(pdf) do |formatter|
              formatter.cell[1,0] = { :text_color => '137d08' }
              formatter.cell[2,0] = { :text_color => 'c1171d' }
              formatter.cell[3,0] = { :text_color => 'f39d27' }
            end
            pdf.move_down 20
            #facility and summary table in first page Statistics in new page  2
          end  
        else
         summary_page_content_draw(pdf)  
        end 
    end


    def summary_page_content_draw(pdf)
      pdf.stamp_at "watermark", [100, 210] if @watermark       
      draw_facility_title(pdf)
      Report::Table.new(dr_facility_summary_table_content).draw(pdf)
      pdf.move_down 20
      draw_title(pdf)
      #project_summary_table(pdf)
      Report::Table.new(dr_project_summary_table_content).draw(pdf)
      pdf.move_down 20
      draw_label(pdf, 'Statistics')
      top = pdf.cursor
      pdf.move_cursor_to top
 
        Report::Table.new(dr_project_statistics_data).draw(pdf) do |formatter|
          formatter.cell[1,0] = { :text_color => '137d08' }
          formatter.cell[2,0] = { :text_color => 'c1171d' }
          #formatter.cell[3,0] = { :text_color => 'f39d27' }

      end  
      pdf.move_down 25
    end

  private

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

    def project_summary_table(pdf)
      pdf.font_size 8
      pdf.table(dr_project_summary_table_content, header: true) do |table|
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

    def dr_facility_summary_table_headings
      ["Building", "Pass", "Fail", "Non-Accessible", "Total", "% of Total"] 
    end

    def dr_facility_summary_table_content
      [dr_facility_summary_table_headings] +  dr_facility_summary_table_data
    end

    def dr_facility_summary_table_data
      #[["Incor9", "5", "5", "0", "10", "100%"]]
      @dr_facility_summaryInfo = Lsspdfasset.select(:u_building, :u_dr_passed_post_repair).where(:u_service_id => @job.u_service_id, :u_delete => false).group(["u_building", "u_dr_passed_post_repair"]).count(:u_dr_passed_post_repair)
      @dr_facility_buildingInfo = []
      
      @dr_facility_summaryInfo.each do |key, value|
        dr_facility_building_json = {}
        if @dr_facility_buildingInfo.length == 0
          dr_facility_building_json["building"] = key[0]
          if key[1] == "Pass"
            dr_facility_building_json["Pass"] = value
            dr_facility_building_json["Fail"] = 0
            dr_facility_building_json["NA"] = 0
          else
            dr_facility_building_json["Pass"] = 0
            dr_facility_building_json["Fail"] = value
            dr_facility_building_json["NA"] = 0
          end
          @dr_facility_buildingInfo.push(dr_facility_building_json)
        else
          @dr_boolean = 0
          @dr_facility_buildingInfo.each do |drinfo|
            if (drinfo.has_value?(key[0]))
              drinfo[key[1]] = value
              @dr_boolean = 1
            end
          end
          if @dr_boolean == 0
            dr_facility_building_json["building"] = key[0]

            if key[1] == "Pass"
              dr_facility_building_json["Pass"] = value
              dr_facility_building_json["Fail"] = 0
              dr_facility_building_json["NA"] = 0
            else
              dr_facility_building_json["Pass"] = 0
              dr_facility_building_json["Fail"] = value
              dr_facility_building_json["NA"] = 0
            end
            @dr_facility_buildingInfo.push(dr_facility_building_json)
          end
        end
      end      

      @dr_facility_grand_total_data = []
      $dr_pass_total = 0
      $dr_fail_total = 0
      $dr_na_total = 0

      @dr_facility_buildingInfo.each do |drtotal|
        $dr_pass_total += drtotal["Pass"]
        $dr_fail_total += drtotal["Fail"]
        $dr_na_total += drtotal["NA"]
      end

      @dr_facility_grand_total_data.push($dr_pass_total)
      @dr_facility_grand_total_data.push($dr_fail_total)
      @dr_facility_grand_total_data.push($dr_na_total)

      @dr_facility_grand_total_data.push($dr_pass_total + $dr_fail_total + $dr_na_total)
      @dr_facility_grand_total_data.push("100.00%")

      @dr_facility_building_table_data = []
      @dr_facility_buildingInfo.each do |drfacilityvalue|

        @dr_facility_total = drfacilityvalue["Pass"] + drfacilityvalue["Fail"] + drfacilityvalue["NA"]
        @dr_facility_grand_total = $dr_pass_total + $dr_fail_total + $dr_na_total
        @dr_facility_per = '%.2f%' % ((100 * @dr_facility_total.to_f) / (@dr_facility_grand_total))

        @dr_facility_building_table_data << [drfacilityvalue["building"], drfacilityvalue["Pass"], drfacilityvalue["Fail"], drfacilityvalue["NA"] , drfacilityvalue["Pass"] + drfacilityvalue["Fail"] + drfacilityvalue["NA"], @dr_facility_per]
      end
      @dr_facility_building_table_data + [['GRAND TOTAL'] + @dr_facility_grand_total_data]
    end

    def dr_project_summary_table_headings
      ["Building", "Type", "Pass", "Fail","Non-Accessible", "Total", "% of Total"]
    end

    def dr_project_summary_table_content
      [dr_project_summary_table_headings] + dr_project_summary_table_data
    end

    def dr_project_summary_table_data
      @dr_project_summary = Lsspdfasset.select(:u_building, :u_type, :u_dr_passed_post_repair).where(:u_service_id => @job.u_service_id, :u_delete => false).where.not(u_type: "").group(["u_building", "u_type", "u_dr_passed_post_repair"]).order("CASE WHEN u_type = 'FD' THEN '1' WHEN u_type = 'SD' THEN '2' ELSE '3' END").count(:u_dr_passed_post_repair)

      @dr_project_summaryInfo = @dr_project_summary.sort_by { |k, v| k[0].capitalize }
      
      @dr_buildingInfo = []

      @dr_project_summaryInfo.each do |key, value|
        dr_building_json = {}

        if @dr_buildingInfo.length == 0
          dr_building_json["building"] = key[0]

          if key[1] == "FD"
            dr_building_json["type"] = "FD"
          elsif key[1] == "SD"
            dr_building_json["type"] = "SD"
          else
            dr_building_json["type"] = "FSD"
          end

          if key[2] == "Pass"
            dr_building_json["Pass"] = value
            dr_building_json["Fail"] = 0
            dr_building_json["NA"] = 0 
          else
            dr_building_json["Pass"] = 0
            dr_building_json["Fail"] = value
            dr_building_json["NA"] = 0 
          end
          @dr_buildingInfo.push(dr_building_json)
        else
          @dr_boolean = 0
          @dr_buildingInfo.each do |drpinfo|
            if (drpinfo.has_value?(key[0]) && drpinfo.has_value?(key[1]))
              if (key[2] ==  "Pass")
                drpinfo["Pass"] = value
              elsif (key[2] ==  "Fail")
                drpinfo["Fail"] = value
              else
                drpinfo["NA"] = 0
              end
              @dr_boolean = 1
            end
          end

          if @dr_boolean == 0
            dr_building_json["building"] = key[0]
            if key[1] == "FD"
              dr_building_json["type"] = "FD"
            elsif key[1] == "SD"
              dr_building_json["type"] = "SD"
            else
              dr_building_json["type"] = "FSD"  
            end

            if key[2] == "Pass"
              dr_building_json["Pass"] = value
              dr_building_json["Fail"] = 0
              dr_building_json["NA"] = 0 
            else
              dr_building_json["Pass"] = 0
              dr_building_json["Fail"] = value
              dr_building_json["NA"] = 0 
            end
            @dr_buildingInfo.push(dr_building_json)
          end 
        end
      end      

      @dr_project_grand_total_data = []
      $dr_p_pass_total = 0
      $dr_p_fail_total = 0
      $dr_p_na_total = 0

      @dr_buildingInfo.each do |drptotalinfo|
        $dr_p_pass_total += drptotalinfo["Pass"]
        $dr_p_fail_total += drptotalinfo["Fail"]
        $dr_p_na_total   += drptotalinfo["NA"]
      end

      @dr_project_grand_total_data.push($dr_p_pass_total)
      @dr_project_grand_total_data.push($dr_p_fail_total)
      @dr_project_grand_total_data.push($dr_p_na_total)
      @dr_project_grand_total_data.push($dr_p_pass_total + $dr_p_fail_total + $dr_p_na_total)
      @dr_project_grand_total_data.push("100.00%")
      
      @dr_project_final_table_data = []
      @dr_buildingInfo.each do |drpresultinfo|
        if drpresultinfo["type"] == "FD"
          @dr_type = "Fire"
        elsif drpresultinfo["type"] == "SD"
          @dr_type = "Smoke"
        else
          @dr_type = "Combination"
        end

        @dr_project_total = drpresultinfo["Pass"] + drpresultinfo["Fail"] + drpresultinfo["NA"]
        @dr_project_grand_total = $dr_p_pass_total + $dr_p_fail_total + $dr_p_na_total
        @dr_project_per = '%.2f%' % ((100 * @dr_project_total.to_f) / (@dr_project_grand_total))
        @dr_project_final_table_data << [drpresultinfo["building"], @dr_type,  drpresultinfo["Pass"], drpresultinfo["Fail"], drpresultinfo["NA"], drpresultinfo["Pass"] + drpresultinfo["Fail"] + drpresultinfo["NA"], @dr_project_per]
      end

      $project_pass_stat = '%.2f%' % (($dr_p_pass_total.to_f * 100) / ($dr_p_pass_total + $dr_p_fail_total + $dr_p_na_total))
      $project_fail_stat = '%.2f%' % (($dr_p_fail_total.to_f * 100) / ($dr_p_pass_total + $dr_p_fail_total + $dr_p_na_total))
      $project_na_stat   = '%.2f%' % (($dr_p_na_total.to_f * 100)   / ($dr_p_pass_total + $dr_p_fail_total + $dr_p_na_total))

      @dr_project_final_table_data + [['GRAND TOTAL', ''] + @dr_project_grand_total_data]
    end

    def dr_project_statistics_data
      [[DamperInspectionReporting.column_heading(:test_result),
       DamperInspectionReporting.column_heading(:percent_of_dampers)]] +
       [[DamperInspectionReporting.column_heading(:pass), $project_pass_stat],
       [DamperInspectionReporting.column_heading(:fail), $project_fail_stat]]
      # [DamperInspectionReporting.column_heading(:na), $project_na_stat]]
    end
  end
end
