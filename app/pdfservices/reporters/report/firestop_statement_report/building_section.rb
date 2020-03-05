module FirestopStatementReport
  class BuildingSection
  	include Report::SectionWritable

    def write(pdf)
      return if statement_records.empty?
      TablePage.new(statement_records, building_section, @tech, @watermark).write(pdf)
      statement_records.each { |r| PhotoPage.new(r, @group_name, @facility_name, @with_picture, @watermark).write(pdf) }
    end
  end
end
