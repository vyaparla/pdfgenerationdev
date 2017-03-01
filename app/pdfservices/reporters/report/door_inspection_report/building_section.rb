module DoorInspectionReport
  class BuildingSection
    include Report::SectionWritable

    def write(pdf)
      return if records.empty?
      TablePage.new(records, building_section, @tech).write(pdf)
      records.each { |r| PhotoPage.new(r).write(pdf) }
    end
  end
end