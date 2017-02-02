class DoorInspectionJob < ActiveRecord::Base

  class << self
  	def reporter_class
      DoorInspectionReporter
    end
  end
end
