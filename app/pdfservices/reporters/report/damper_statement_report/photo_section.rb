module DamperStatementReport
  class PhotoSection
    include Report::SectionWritable

    def write(pdf)
      comprehensive_records.each { |r| PhotoPage.new(r, @group_name, @facility_name, @with_picture).write(pdf) }
    end
  end
end