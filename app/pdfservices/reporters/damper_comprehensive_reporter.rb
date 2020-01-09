class DamperComprehensiveReporter < Reporter

  def report(job, model_name, address1, address2, csz, facility_type, tech, group_name, 
    facility_name, facility_id, with_picture=true)

    DamperComprehensiveReport::GraphGenerator.new(job).generate
  
  	generate(job.full_comprehensive_report_path(with_picture, model_name)) do |pdf|
  	  Report::CoverPage.new(job, model_name, address1, address2, csz, facility_name, tech ).write(pdf)
  	  DamperComprehensiveReport::LetterPage.new(job, model_name, address1, address2, csz, facility_type, 
      facility_name, tech).write(pdf)
      DamperComprehensiveReport::ProjectSummaryPage.new(job, tech).write(pdf)
      DamperComprehensiveReport::GraphPage.new(job, tech).write(pdf)
  	  job.damper_comprehensive_buildings(facility_id).each do |b|
        DamperComprehensiveReport::BuildingSection.new(job, b, tech, group_name, facility_name, with_picture).write(pdf)
        #DamperRepairReport::TablePage.new(job, b, tech, group_name, facility_name, with_picture).write(pdf)
        #DamperComprehensiveReport::PhotoSection.new(job, b, tech, group_name, facility_name, with_picture).write(pdf)
      end
  	  Report::BackPage.new.write(pdf)
  	end
  end
  
end
