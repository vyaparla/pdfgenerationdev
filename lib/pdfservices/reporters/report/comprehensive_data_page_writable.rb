module Report
  module ComprehensiveDataPageWritable
  	include DamperComprehensiveDataPageWritable

  private

    def date_key
      :inspection_date
    end

    def technician_key
      :inspected_by
    end
  end
end