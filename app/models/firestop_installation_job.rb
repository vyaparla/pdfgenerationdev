class FirestopInstallationJob < ActiveRecord::Base

  class << self
    def reporter_class
      FirestopInstallationReporter
    end
    def projectcompletion_reporter_class
      FirestopInstallationProjectCompletionReporter
    end
  end
end
