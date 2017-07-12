module DoorInspectionReport
  class ProjectSummaryPage
  	include Report::InspectionDataPageWritable

  	def initialize(job, tech)
      @job = job
      @tech = tech
    end

    def write(pdf)
      super
      #draw_firedoor_project_summary(pdf)
      draw_facility_title(pdf)
      Report::Table.new(firedoor_facility_summary_table_content).draw(pdf)
      pdf.move_down 30
      draw_title(pdf)
      pdf.move_down 5
      draw_label(pdf, 'Statistics')
      pdf.move_down 10
      draw_firedoor_door_by_rating(pdf)
    end

  private

    def draw_facility_title(pdf)
      pdf.font_size 40
      pdf.fill_color 'f39d27'
      pdf.text("<b>Facility Building Summary</b>", :inline_format => true)
      pdf.fill_color '202020'
      pdf.move_down 10
    end

    def firedoor_facility_summary_table_headings
      ["Building", "Total # Deficiencies Found", "Total # Deficiencies Addressed This Project", "Total # Deficiencies Remaining"]
    end

    def firedoor_facility_summary_table_content
      [firedoor_facility_summary_table_headings] + firedoor_facility_summary_table_data
    end

    def firedoor_facility_summary_table_data
      #[["Main Bulding", 10, 6, 4], ["Main Bulding-2", 5, 3, 2]] + [["Grand Total", 15, 9, 6]]
      @firedoor_facility_summaryInfo = Lsspdfasset.select(:u_building, :u_door_inspection_result).where(:u_service_id => @job.u_service_id, :u_delete => false).group(["u_building", "u_door_inspection_result"]).count(:u_door_inspection_result)
      @firedoor_facility_buildingInfo = []
      
      @firedoor_facility_summaryInfo.each do |key, value|
        firedoor_facility_building_json = {}
        if @firedoor_facility_buildingInfo.length == 0
          firedoor_facility_building_json["building"] = key[0]
          if key[1] == "Conform"
            firedoor_facility_building_json["Conform"] = value
            firedoor_facility_building_json["Non-Conforming"] = 0
          else
            firedoor_facility_building_json["Conform"] = 0
            firedoor_facility_building_json["Non-Conforming"] = value
          end
          @firedoor_facility_buildingInfo.push(firedoor_facility_building_json)
        else
          @firedoor_boolean = 0
          @firedoor_facility_buildingInfo.each do |firedoorinfo|
            if (firedoorinfo.has_value?(key[0]))
              firedoorinfo[key[1]] = value
              @firedoor_boolean = 1
            end
          end
          if @firedoor_boolean == 0
            firedoor_facility_building_json["building"] = key[0]

            if key[1] == "Conform"
              firedoor_facility_building_json["Conform"] = value
              firedoor_facility_building_json["Non-Conforming"] = 0
            else
              firedoor_facility_building_json["Conform"] = 0
              firedoor_facility_building_json["Non-Conforming"] = value
            end
            @firedoor_facility_buildingInfo.push(firedoor_facility_building_json)
          end
        end
      end

      @firedoor_facility_grand_total_data = []
      $deficienciesfound = 0
      $door_conform = 0
      $door_nonconforming = 0

      @firedoor_facility_buildingInfo.each do |doortotal|
        $deficienciesfound += doortotal["Conform"] + doortotal["Non-Conforming"]
        $door_conform += doortotal["Conform"]
        $door_nonconforming += doortotal["Non-Conforming"]
      end

      @firedoor_facility_grand_total_data.push($deficienciesfound)
      @firedoor_facility_grand_total_data.push($door_conform)
      @firedoor_facility_grand_total_data.push($door_nonconforming)

      @firedoor_facility_building_table_data = []
      @firedoor_facility_buildingInfo.each do |facilityvalue|
        @firedoor_facility_building_table_data << [facilityvalue["building"], facilityvalue["Conform"] + facilityvalue["Non-Conforming"], facilityvalue["Conform"], facilityvalue["Non-Conforming"]]
      end
      @firedoor_facility_building_table_data + [['GRAND TOTAL'] + @firedoor_facility_grand_total_data]
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
    end

    def draw_firedoor_door_by_rating(pdf)
      pdf.font_size 10
      pdf.fill_color '202020'
      pdf.text("Door By Rating", :inline_format => true)
      pdf.move_down 10
      firedoor_doorbyrating = []
      firedoor_doorbyrating << ["Type", "Total", "% of Doors"]
      @firedoor_door_by_rating = Lsspdfasset.select(:u_fire_rating).where(:u_service_id => @job.u_service_id, :u_delete => false).where.not(u_fire_rating: "").group(["u_fire_rating"]).count(:u_fire_rating)
      @firedoor_door_by_rating_count = 0
      @firedoor_door_by_rating.each do |key, value|
        @firedoor_door_by_rating_count += value
      end
      
      @firedoor_door_by_rating.each do |key, value|
        firedoor_doorbyrating << [key, value, "#{((value.to_f * 100 ) / @firedoor_door_by_rating_count).round(2)}%"]
      end
      pdf.font_size 10
      pdf.table(firedoor_doorbyrating, header: true) do |table|
        table.row_colors = ['ffffff', 'eaeaea']
        table.rows(0).style {|r| r.border_color = '888888'}
        table.rows(1..(table.row_length-1)).style do |r|
          r.border_color = 'cccccc'
        end
        table.row(0).style background_color: '444444',
                           text_color:       'ffffff'
        table.column(1).style {|c| c.align = :center }
        table.column(2).style {|c| c.align = :center }
      end
    end
  end
end