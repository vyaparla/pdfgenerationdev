class DamperInspectionReporter < Reporter
  def summary_report(job, model_name, address, facility_type, tech)
    Report::DamperGraphGenerator.new(job).generate
    generate(job.summary_report_path) do |pdf|
      Report::CoverPage.new(job, model_name, address).write(pdf)
      DamperInspectionReport::ProjectSummaryPage.new(job, tech).write(pdf)
      DamperInspectionReport::GraphPage.new(job).write(pdf)
    end
  end

  def report(job, model_name, address, facility_type, tech)
    Report::DamperGraphGenerator.new(job).generate
  	generate(job.full_report_path) do |pdf|
  	  Report::CoverPage.new(job, model_name, address).write(pdf)
  	  DamperInspectionReport::LetterPage.new(job, model_name, address, facility_type, tech).write(pdf)
      DamperInspectionReport::ProjectSummaryPage.new(job, tech).write(pdf)
      DamperInspectionReport::GraphPage.new(job, tech).write(pdf)
      job.buildings(job.u_service_id).each do |b|
        DamperInspectionReport::BuildingSection.new(job, b, tech).write(pdf)
      end
  	  Report::BackPage.new.write(pdf)
  	end
  end
end