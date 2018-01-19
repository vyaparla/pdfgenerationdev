class FirestopInstallationReporter < Reporter
  def summary_report(job, model_name, address, tech)
    generate(job.summary_report_path) do |pdf|
      Report::CoverPage.new(job, model_name, address).write(pdf)
      job.buildings(job.u_service_id).each do |b|
        FirestopInstallationReport::TablePage.new(job, b, tech).write(pdf)
      end
    end
  end

  def report(job, model_name, address1, address2, csz, facility_type, tech)
    FirestopInstallationReport::GraphGenerator.new(job).generate
  	generate(job.full_report_path) do |pdf|
  	  Report::CoverPage.new(job, model_name, address1, address2, csz).write(pdf)
      FirestopInstallationReport::SummaryPage.new(job, tech).write(pdf)
  	  job.buildings(job.u_service_id).each do |b|
        FirestopInstallationReport::TablePage.new(job, b, tech).write(pdf)
        FirestopInstallationReport::PhotoSection.new(job, b, tech).write(pdf)
      end
      Report::BackPage.new.write(pdf)
  	end
  end
end