class DamperComprehensiveReporter < Reporter
  def summary_report(job, model_name, address1, address2, csz, tech, group_name, facility_name)
    DamperComprehensiveReport::GraphGenerator.new(job).generate
    generate(job.summary_report_path) do |pdf|
      Report::CoverPage.new(job, model_name, address).write(pdf)
      DamperComprehensiveReport::ProjectSummaryPage.new(job, tech).write(pdf)
      DamperComprehensiveReport::GraphPage.new(job, tech).write(pdf)
    end
  end

  def report(job, model_name, address1, address2, csz, facility_type, tech, group_name, 
    facility_name, with_picture=true)
  
    work_dates = job.order('updated_at DESC')
    @start_date  = work_dates.first
    @end_date = work_dates.last

     job.each do |j|
    DamperComprehensiveReport::GraphGenerator.new(j).generate
  
  	generate(j.full_report_path(with_picture)) do |pdf|
  	  Report::CoverPage.new(j, model_name, address1, address2, csz, facility_name, tech ).write(pdf)
  	  DamperComprehensiveReport::LetterPage.new(j, model_name, address1, address2, csz, facility_type, 
        facility_name, tech, @start_date,@end_date).write(pdf)
      DamperComprehensiveReport::ProjectSummaryPage.new(j, tech).write(pdf)
      DamperComprehensiveReport::GraphPage.new(j, tech).write(pdf)
  	  j.buildings(j.u_service_id).each do |b|
        DamperComprehensiveReport::BuildingSection.new(j, b, tech, group_name, facility_name, with_picture).write(pdf)
        #DamperRepairReport::TablePage.new(job, b, tech, group_name, facility_name, with_picture).write(pdf)
        DamperComprehensiveReport::PhotoSection.new(j, b, tech, group_name, facility_name, with_picture).write(pdf)
      end
  	  Report::BackPage.new.write(pdf)
  	end
    end
  end
end
