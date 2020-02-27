module DamperStatementReport
  class UpdateDate

    def generate
      puts "i'm in update date generate"
      lss = Lsspdfasset.select('id', 'updated_at').order('id DESC').limit 12
      lss.each do |ld|  
         puts "------#{ld.id}"
         lr = Lsspdfasset.find(ld.id)                                                                                                
         ActiveRecord::Base.record_timestamps = false                                                                                
         lr.update_attributes(u_updated_date: ld.updated_at)                                                                         
      end 
    end

  end
end
