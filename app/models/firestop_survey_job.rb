class FirestopSurveyJob < ActiveRecord::Base
  class << self
    def reporter_class
      FirestopSurveyReporter
    end
    def projectcompletion_reporter_class
      FirestopSurveyProjectCompletionReporter
    end
  end
end
