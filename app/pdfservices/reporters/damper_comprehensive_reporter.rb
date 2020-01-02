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
    facility_name, facility_id, with_picture=true)

    #   puts "***********************"
    #   puts job.inspect
 
    # work_dates = job.order('updated_at DESC')
    # @start_date  = work_dates.first
    # @end_date = work_dates.last

    DamperComprehensiveReport::GraphGenerator.new(job).generate
  
  	generate(job.full_comprehensive_report_path(with_picture)) do |pdf|
  	  Report::CoverPage.new(job, model_name, address1, address2, csz, facility_name, tech ).write(pdf)
  	  DamperComprehensiveReport::LetterPage.new(job, model_name, address1, address2, csz, facility_type, 
      facility_name, tech).write(pdf)
      DamperComprehensiveReport::ProjectSummaryPage.new(job, tech).write(pdf)
      DamperComprehensiveReport::GraphPage.new(job, tech).write(pdf)
  	  job.buildings(job.u_service_id).each do |b|
        DamperComprehensiveReport::BuildingSection.new(job, b, tech, group_name, facility_name, with_picture).write(pdf)
        #DamperRepairReport::TablePage.new(job, b, tech, group_name, facility_name, with_picture).write(pdf)
        DamperComprehensiveReport::PhotoSection.new(job, b, tech, group_name, facility_name, with_picture).write(pdf)
      end
  	  Report::BackPage.new.write(pdf)
  	end
  end
end
