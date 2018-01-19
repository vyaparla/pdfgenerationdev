class FirestopSurveyReporter < Reporter
  def summary_report(job, model_name, address1, address2, csz, tech)
    FirestopSurveyReport::GraphGenerator.new(job).generate
    generate(job.summary_report_path) do |pdf|
      Report::CoverPage.new(job, model_name, address1, address2, csz).write(pdf)
      FirestopSurveyReport::SummaryPage.new(job, tech).write(pdf)
      #FirestopSurveyReport::GraphPage.new(job, tech).write(pdf)
    end
  end

  def report(job, model_name, address1, address2, csz, facility_type, tech)
  	FirestopSurveyReport::GraphGenerator.new(job).generate
  	generate(job.full_report_path) do |pdf|
  	  Report::CoverPage.new(job, model_name, address1, address2, csz).write(pdf)
  	  FirestopSurveyReport::SummaryPage.new(job, tech).write(pdf)
  	  #FirestopSurveyReport::GraphPage.new(job, tech).write(pdf)
  	  job.buildings(job.u_service_id).each do |b|
        FirestopSurveyReport::BuildingSection.new(job, b, tech).write(pdf)
      end
      Report::BackPage.new.write(pdf)
  	end
  end
end