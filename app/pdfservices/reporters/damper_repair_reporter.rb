class DamperRepairReporter < Reporter
  def summary_report(job, model_name, address1, address2, csz, tech, group_name, facility_name)
    DamperRepairReport::GraphGenerator.new(job).generate
    generate(job.summary_report_path) do |pdf|
      Report::CoverPage.new(job, model_name, address).write(pdf)
      DamperRepairReport::ProjectSummaryPage.new(job, tech).write(pdf)
      DamperRepairReport::GraphPage.new(job, tech).write(pdf)
    end
  end

  def report(job, model_name, address1, address2, csz, facility_type, tech, group_name, 
    facility_name, with_picture=true)
    DamperRepairReport::GraphGenerator.new(job).generate
  	generate(job.full_report_path(with_picture)) do |pdf|
  	  Report::CoverPage.new(job, model_name, address1, address2, csz, facility_name, tech ).write(pdf)
  	  DamperRepairReport::LetterPage.new(job, model_name, address1, address2, csz, facility_type, facility_name, tech).write(pdf)
      DamperRepairReport::ProjectSummaryPage.new(job, tech).write(pdf)
      DamperRepairReport::GraphPage.new(job, tech).write(pdf)
  	  job.buildings(job.u_service_id).each do |b|
        DamperRepairReport::BuildingSection.new(job, b, tech, group_name, facility_name, with_picture).write(pdf)
        #DamperRepairReport::TablePage.new(job, b, tech, group_name, facility_name, with_picture).write(pdf)
        #DamperRepairReport::PhotoSection.new(job, b, tech, group_name, facility_name, with_picture).write(pdf)
      end
  	  Report::BackPage.new.write(pdf)
  	end
  end
end
