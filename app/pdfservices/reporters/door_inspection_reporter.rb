class DoorInspectionReporter < Reporter
  def summary_report(job, model_name, address1, address2, csz, tech)
    generate(job.summary_report_path) do |pdf|
      Report::CoverPage.new(job, model_name, address).write(pdf)
    end
  end

  def report(job, model_name, address1, address2, csz, facility_type, tech)
    DoorInspectionReport::GraphGenerator.new(job).generate
    generate(job.full_report_path) do |pdf|
      Report::CoverPage.new(job, model_name, address1, address2, csz).write(pdf)
      DoorInspectionReport::LetterPage.new(job, model_name, address1, address2, csz, facility_type, tech).write(pdf)
      DoorInspectionReport::ProjectSummaryPage.new(job, tech).write(pdf)
      DoorInspectionReport::GraphPage.new(job, tech).write(pdf)
      #DoorInspectionReport::DoorScorePage.new.write(pdf)
      #DoorInspectionReport::SummaryPage.new(job, tech).write(pdf)
       job.buildings(job.u_service_id).each do |b|
        DoorInspectionReport::BuildingSection.new(job, b, tech).write(pdf)
      end
      Report::BackPage.new.write(pdf)
    end
  end
end