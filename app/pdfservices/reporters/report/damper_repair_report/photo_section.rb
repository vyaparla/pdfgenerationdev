module DamperRepairReport
  class PhotoSection
    include Report::SectionWritable

    def write(pdf)
      records.each { |r| PhotoPage.new(r).write(pdf) }
    end
  end
end