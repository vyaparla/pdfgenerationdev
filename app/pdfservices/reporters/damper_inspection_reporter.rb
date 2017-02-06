class DamperInspectionReporter < Reporter
  def report(job, model_name, address, facility_type)
    Report::DamperGraphGenerator.new(job).generate
  	generate(job.full_report_path) do |pdf|
  	  Report::CoverPage.new(job, model_name).write(pdf)
  	  DamperInspectionReport::LetterPage.new(job, model_name, address, facility_type).write(pdf)
      DamperInspectionReport::ProjectSummaryPage.new(job).write(pdf)
      DamperInspectionReport::GraphPage.new(job).write(pdf)
      job.buildings(job.u_service_id).each do |b|
        DamperInspectionReport::BuildingSection.new(job, b).write(pdf)
      end
  	  Report::BackPage.new.write(pdf)
  	end
  end
end