class DamperRepairJob < ActiveRecord::Base

  class << self
  	def reporter_class
      DamperRepairReporter
    end
  end

end
