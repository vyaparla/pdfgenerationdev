class FirestopSurveyJob < ActiveRecord::Base
  class << self
    def reporter_class
      FirestopSurveyReporter
    end
  end
end
