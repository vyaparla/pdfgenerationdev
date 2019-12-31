class FirestopComprehensiveJob < ActiveRecord::Base
  class << self
    def reporter_class
      FirestopComprehensiveReporter
    end
  end
end
