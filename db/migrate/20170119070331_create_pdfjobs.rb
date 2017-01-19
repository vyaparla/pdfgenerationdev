class CreatePdfjobs < ActiveRecord::Migration
  def change
    create_table :pdfjobs do |t|
      t.string   :u_job_id
      t.string   :u_pdf_number
      t.text     :u_openimage_base64code, :limit => 1073741823
      t.text     :u_close_image_base64code, :limit => 1073741823
      t.timestamps null: false
    end
  end
end