class DamperRepairJob < ActiveRecord::Base

  class << self
  	
  	def reporter_class
      DamperRepairReporter
    end

    def projectcompletion_reporter_class
      DamperRepairProjectCompletionReporter
    end
  end
end
