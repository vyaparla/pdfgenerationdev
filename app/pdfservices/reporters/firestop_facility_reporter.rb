class FirestopFacilityReporter < Reporter

  def comprehensive_report(job, model_name, address1, address2, csz, facility_type, tech, group_name, facility_name, facility_id, with_picture=true, report_type)
     FirestopComprehensiveReport::GraphGenerator.new(job).generate
     generate(job.full_facilitywise_report_path(with_picture, model_name, report_type)) do |pdf|
       Report::CoverPage.new(job, model_name="Firestop Comprehensive", address1, address2, csz, facility_name, tech).write(pdf)
       FirestopComprehensiveReport::SummaryPage.new(job, tech).write(pdf)
       job.comprehensive_buildings(facility_id).each do |b|
         FirestopComprehensiveReport::BuildingSection.new(job, b, tech, group_name, facility_id, with_picture).write(pdf)
       end
       Report::BackPage.new.write(pdf)
     end
  end

  def statement_report(job, model_name, address1, address2, csz, facility_type, tech, group_name, facility_name, facility_id, with_picture=true, report_type)
     FirestopStatementReport::GraphGenerator.new(job).generate
     generate(job.full_facilitywise_report_path(with_picture, model_name, report_type)) do |pdf|
       Report::CoverPage.new(job, model_name="Firestop Statement", address1, address2, csz, facility_name, tech).write(pdf)
       FirestopStatementReport::SummaryPage.new(job, tech).write(pdf)
       job.comprehensive_buildings(facility_id).each do |b|
         FirestopStatementReport::BuildingSection.new(job, b, tech, group_name, facility_id, with_picture).write(pdf)
       end
       Report::BackPage.new.write(pdf)
     end
  end


end