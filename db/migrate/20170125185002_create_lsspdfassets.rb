class CreateLsspdfassets < ActiveRecord::Migration
  def change
    create_table :lsspdfassets do |t|
      t.string   :sys_id
      t.string   :u_job_id
      t.string   :u_asset_id
      t.string   :u_service_id
      t.string   :u_location_desc
      t.string   :u_status
      t.string   :u_type
      t.string   :u_floor
      t.string   :u_tag
      t.text     :u_image1, :limit => 1073741823
      t.text     :u_image2, :limit => 1073741823
      t.text     :u_image3, :limit => 1073741823
      t.text     :u_image4, :limit => 1073741823
      t.text     :u_image5, :limit => 1073741823
      t.timestamps null: false
    end
  end
end
