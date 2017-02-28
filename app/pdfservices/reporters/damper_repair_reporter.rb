class DamperRepairReporter < Reporter
  def summary_report(job, model_name, address, facility_type)
    generate(job.summary_report_path) do |pdf|
      Report::CoverPage.new(job, model_name).write(pdf)
    end
  end

  def report(job, model_name, address, facility_type)
  	generate(job.full_report_path) do |pdf|
  	  Report::CoverPage.new(job, model_name).write(pdf)
  	  #DamperRepairReport::ProjectSummaryPage.new(job).write(pdf)
  	  job.buildings(job.u_service_id).each do |b|
        DamperRepairReport::TablePage.new(job, b).write(pdf)
        DamperRepairReport::PhotoSection.new(job, b).write(pdf)
      end
  	  Report::BackPage.new.write(pdf)
  	end
  end
end