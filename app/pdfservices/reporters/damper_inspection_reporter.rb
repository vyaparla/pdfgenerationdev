class DamperInspectionReporter < Reporter
  def summary_report(job, model_name, address1, address2, csz, tech, group_name, facility_name)
    Report::DamperGraphGenerator.new(job).generate
    generate(job.summary_report_path) do |pdf|
      Report::CoverPage.new(job, model_name, address1, address2, csz).write(pdf)
      DamperInspectionReport::ProjectSummaryPage.new(job, tech).write(pdf)
      DamperInspectionReport::GraphPage.new(job, tech).write(pdf)
    end
  end

  def report(job, model_name, address1, address2, csz,facility_type, tech, group_name, facility_name, with_picture)
    Report::DamperGraphGenerator.new(job).generate
  	generate(job.full_report_path(with_picture)) do |pdf|
  	  Report::CoverPage.new(job, model_name, address1, address2, csz).write(pdf)
  	  DamperInspectionReport::LetterPage.new(job, model_name, address1, address2, csz, facility_type, tech).write(pdf)
      DamperInspectionReport::ProjectSummaryPage.new(job, tech).write(pdf)
      DamperInspectionReport::GraphPage.new(job, tech).write(pdf)
      job.buildings(job.u_service_id).each do |b|
        DamperInspectionReport::BuildingSection.new(job, b, tech, group_name, facility_name, with_picture).write(pdf)
      end
  	  Report::BackPage.new.write(pdf)
  	end
  end
end
