class FirestopInstallationJob < ActiveRecord::Base

  class << self
    def reporter_class
      FirestopInstallationReporter
    end
  end
end
