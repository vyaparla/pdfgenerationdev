class DamperRepairReporter < Reporter
  def report(job, model_name, address, facility_type)
  	generate(job.full_report_path) do |pdf|
  	  Report::CoverPage.new(job, model_name).write(pdf)
  	  Report::BackPage.new.write(pdf)
  	end
  end
end