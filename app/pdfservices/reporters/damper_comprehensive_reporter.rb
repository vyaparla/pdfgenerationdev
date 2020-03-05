class DamperComprehensiveReporter < Reporter

  def comprehensive_report(job, model_name, address1, address2, csz, facility_type, tech, group_name, 
    facility_name, facility_id, with_picture=true, report_type, watermark)

    DamperComprehensiveReport::GraphGenerator.new(job).generate
  
  	generate(job.full_facilitywise_report_path(with_picture, model_name, report_type)) do |pdf|
  	  Report::CoverPage.new(job, model_name, address1, address2, csz, facility_name, tech, watermark).write(pdf)
  	  DamperComprehensiveReport::LetterPage.new(job, model_name, address1, address2, csz, facility_type, 
      facility_name, tech, report_type, watermark).write(pdf)
      DamperComprehensiveReport::ProjectSummaryPage.new(job, tech, report_type, watermark).write(pdf)
      DamperComprehensiveReport::GraphPage.new(job, tech, report_type, watermark).write(pdf)
  	  job.damper_comprehensive_buildings(facility_id).each do |b|
        DamperComprehensiveReport::BuildingSection.new(job, b, tech, group_name, facility_name, with_picture, watermark).write(pdf)
        #DamperRepairReport::TablePage.new(job, b, tech, group_name, facility_name, with_picture).write(pdf)
        #DamperComprehensiveReport::PhotoSection.new(job, b, tech, group_name, facility_name, with_picture).write(pdf)
      end
  	  Report::BackPage.new.write(pdf)
      pdf.stamp_at "watermark", [100, 210]  if watermark
  	end
  end
  
end
