module Report
  module RepairDataPageWritable
    include DataPageWritable

  private

    def date_key
      :repair_date
    end

    def technician_key
      :repaired_by
    end
  end
end