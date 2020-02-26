namespace :lssassets do
  desc "Update u_updated_date with updated_at"
 
  task :update_date => :environment do
    lss = Lsspdfasset.select('id', 'updated_at').order('id DESC').limit 10 
    lss.each do |ld|  
       lr = Lsspdfasset.find(ld.id)                                                                                                
       ActiveRecord::Base.record_timestamps = false                                                                                
       lr.update_attributes(u_updated_date: ld.updated_at)                                                                         
    end 
   end
end