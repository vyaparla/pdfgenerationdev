class FirestopFacilityJob < ActiveRecord::Base
  class << self
    def reporter_class
      FirestopFacilityReporter
    end
  end
end
