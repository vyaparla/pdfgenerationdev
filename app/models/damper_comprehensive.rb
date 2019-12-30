class DamperComprehensive < ActiveRecord::Base

	class << self
  	
  	def reporter_class
      DamperComprehensiveReporter
    end

  end

end
