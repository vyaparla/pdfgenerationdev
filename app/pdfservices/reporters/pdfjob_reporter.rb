class PdfjobReporter < Reporter
  
  def report(job)
  	generate(job.full_report_path) do |pdf|
  	  Report::CoverPage.new(job).write(pdf)
  	  Pdfjob.all.each do |r|
  	  	PdfjobReport::PhotoPage.new(r).write(pdf)
  	  end
  	  Report::BackPage.new.write(pdf)
    end
  end
end