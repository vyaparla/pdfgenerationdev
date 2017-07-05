class DoorInspectionJob < ActiveRecord::Base

  class << self
  	def reporter_class
      DoorInspectionReporter
    end
    
    def projectcompletion_reporter_class      
      DoorInspectionProjectCompletionReporter
    end
  end
end
