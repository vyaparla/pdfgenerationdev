class DoorInspectionProjectCompletionReporter < Reporter

  def report(project)
  	generate(project.project_completion_full_path) do |pdf|
  	  Report::CommonDetailPage.new(project).write(pdf)
  	  FDIProjectCompletionReport::ProjectCompletionDetailPage.new(project).write(pdf)
      Report::AcknowledgeDetailPage.new(project).write(pdf)
  	end
  end
end