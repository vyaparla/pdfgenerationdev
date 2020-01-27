class DamperStatementJob < ActiveRecord::Base
  class << self
  	
  	def reporter_class
      DamperStatementReporter
    end

  end
end


