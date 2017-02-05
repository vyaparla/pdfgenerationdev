class FirestopSurveyReporter < Reporter
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