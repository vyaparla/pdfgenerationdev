module FirestopStatementReport
  class BuildingSection
  	include Report::SectionWritable

    def write(pdf)
      return if comprehensive_records.empty?
      TablePage.new(comprehensive_records, building_section, @tech).write(pdf)
      comprehensive_records.each { |r| PhotoPage.new(r, @group_name, @facility_name, @with_picture).write(pdf) }
    end
  end
end
