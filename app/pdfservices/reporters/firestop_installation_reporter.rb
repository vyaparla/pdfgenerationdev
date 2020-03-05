class FirestopInstallationReporter < Reporter
  def summary_report(job, model_name, address, tech, group_name, facility_name)
    generate(job.summary_report_path) do |pdf|
      Report::CoverPage.new(job, model_name, address).write(pdf)
      job.buildings(job.u_service_id).each do |b|
        FirestopInstallationReport::TablePage.new(job, b, tech).write(pdf)
      end
    end
  end

  def report(job, model_name, address1, address2, csz, facility_type, tech, 
    group_name, facility_name, with_picture=true, watermark)

    FirestopInstallationReport::GraphGenerator.new(job).generate
  	generate(job.full_report_path(with_picture)) do |pdf|
  	  Report::CoverPage.new(job, model_name, address1, address2, csz, facility_name, tech, watermark).write(pdf)
      FirestopInstallationReport::SummaryPage.new(job, tech, watermark).write(pdf)
  	  job.buildings(job.u_service_id).each do |b|
        FirestopInstallationReport::TablePage .new(job, b, tech, watermark).write(pdf)
        FirestopInstallationReport::PhotoSection.
          new(job, b, tech, group_name, facility_name, with_picture, watermark).write(pdf)
      end
      Report::BackPage.new.write(pdf)
      pdf.stamp_at "watermark", [100, 210]  if watermark
  	end
  end
end
