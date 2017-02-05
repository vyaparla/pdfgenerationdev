module FirestopSurveyReport
  class BuildingSection
  	include Report::SectionWritable

    def write(pdf)
      return if records.empty?
      TablePage.new(records, building_section).write(pdf)
      records.each { |r| PhotoPage.new(r).write(pdf) }
    end
  end
end