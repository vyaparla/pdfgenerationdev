class FirestopSurveyReporter < Reporter
  def summary_report(job, model_name, address, facility_type)
    FirestopSurveyReport::GraphGenerator.new(job).generate
    generate(job.summary_report_path) do |pdf|
      Report::CoverPage.new(job, model_name).write(pdf)
      FirestopSurveyReport::SummaryPage.new(job).write(pdf)
      FirestopSurveyReport::GraphPage.new(job).write(pdf)
    end
  end

  def report(job, model_name, address, facility_type)
  	FirestopSurveyReport::GraphGenerator.new(job).generate
  	generate(job.full_report_path) do |pdf|
  	  Report::CoverPage.new(job, model_name).write(pdf)
  	  FirestopSurveyReport::SummaryPage.new(job).write(pdf)
  	  FirestopSurveyReport::GraphPage.new(job).write(pdf)
  	  job.buildings(job.u_service_id).each do |b|
        FirestopSurveyReport::BuildingSection.new(job, b).write(pdf)
      end
      Report::BackPage.new.write(pdf)
  	end
  end
end