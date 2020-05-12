desc 'Update existing old assets as part of LP-783'
task :update_prev_assets  => :environment do
  path = Rails.root.to_s + "/testdata.csv"

  puts path
  CSV.foreach(path) do |row|

  puts row[0]
  puts row[1]
  puts row
  find_asset =  Lsspdfasset.where(:u_asset_id => row[0]).first
  find_asset.update(:u_updated_date => row[1]) if find_asset.present?
 # find_asset = Lsspdfasset.select("id, u_tag, u_asset_id, u_facility_name").where(:u_asset_id => ).first
  #test_sql = "select id, u_tag, u_asset_id, u_facility_name from lsspdfassets where u_asset_id = 'd3157b16db1f4c50d17be1c2ca961975';"
  puts "Running Queries"
  #puts test_sql.gsub(/\n\s*/, ' ')
 row_first = find_asset
  if row_first.present? 
  puts row_first.id
  puts row_first.u_tag
  puts row_first.u_asset_id
  puts row_first.u_facility_name
  end
  puts "After Execution"

end
end

