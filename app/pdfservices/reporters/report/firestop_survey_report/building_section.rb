module FirestopSurveyReport
  class BuildingSection
  	include Report::SectionWritable

    def write(pdf)
      return if records.empty?
      TablePage.new(records, building_section, @tech, @watermark).write(pdf)
      records.each { |r| PhotoPage.new(r, @group_name, @facility_name, @with_picture, @watermark).write(pdf) }
    end
  end
end