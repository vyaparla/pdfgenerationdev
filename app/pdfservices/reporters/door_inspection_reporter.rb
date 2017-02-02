class DoorInspectionReporter < Reporter
  def report(job, model_name, address, facility_type)
    generate(job.full_report_path) do |pdf|
      Report::CoverPage.new(job, model_name).write(pdf)
      DoorInspectionReport::LetterPage.new(job, address, facility_type).write(pdf)
      DoorInspectionReport::DoorScorePage.new.write(pdf)
      Report::BackPage.new.write(pdf)
    end
  end
end