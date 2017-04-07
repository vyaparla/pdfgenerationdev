class DamperRepairReporter < Reporter
  def summary_report(job, model_name, address, tech)
    DamperRepairReport::GraphGenerator.new(job).generate
    generate(job.summary_report_path) do |pdf|
      Report::CoverPage.new(job, model_name, address).write(pdf)
      DamperRepairReport::ProjectSummaryPage.new(job, tech).write(pdf)
      DamperRepairReport::GraphPage.new(job, tech).write(pdf)
    end
  end

  def report(job, model_name, address, facility_type, tech)
    DamperRepairReport::GraphGenerator.new(job).generate
  	generate(job.full_report_path) do |pdf|
  	  Report::CoverPage.new(job, model_name, address).write(pdf)
  	  DamperRepairReport::ProjectSummaryPage.new(job, tech).write(pdf)
      DamperRepairReport::GraphPage.new(job, tech).write(pdf)
  	  job.buildings(job.u_service_id).each do |b|
        DamperRepairReport::BuildingSection.new(job, b, tech).write(pdf)
        # DamperRepairReport::TablePage.new(job, b, tech).write(pdf)
        # DamperRepairReport::PhotoSection.new(job, b, tech).write(pdf)
      end
  	  Report::BackPage.new.write(pdf)
  	end
  end
end