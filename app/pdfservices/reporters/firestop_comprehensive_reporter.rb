class FirestopComprehensiveReporter < Reporter

  def comprehensive_report(job, model_name, address1, address2, csz, facility_type, tech, group_name, facility_name, facility_id, with_picture=true)
     #FirestopComprehensiveReport::GraphGenerator.new(job).generate
     generate(job.full_comprehensive_report_path(with_picture)) do |pdf|
       Report::CoverPage.new(job, model_name="Firestop Comprehensive", address1, address2, csz, facility_name, tech).write(pdf)
       FirestopComprehensiveReport::SummaryPage.new(job, tech).write(pdf)
       job.buildings(job.u_service_id).each do |b|
         FirestopComprehensiveReport::BuildingSection.new(job, b, tech, group_name, facility_name, with_picture).write(pdf)
       end
       Report::BackPage.new.write(pdf)
     end
  end

end
