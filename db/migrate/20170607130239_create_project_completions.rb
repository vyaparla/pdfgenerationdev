class CreateProjectCompletions < ActiveRecord::Migration
  def change
    create_table :project_completions do |t|
      t.string   :m_job_id
      t.string   :m_service_sysid
      t.datetime :m_date
      t.string   :m_facility
      t.string   :m_building
      t.string   :m_servicetype
      t.datetime :m_project_start_date
      t.string   :m_primary_contact_name
      t.string   :m_phone
      t.string   :m_printed_report
      t.string   :m_autocad
      t.string   :m_total_no_of_dampers_inspected
      t.string   :m_total_no_of_dampers_passed
      t.string   :m_total_no_of_dampers_na
      t.string   :m_total_no_of_damper_access_door_installed
      t.string   :m_total_no_of_dampers_repaired
      t.string   :m_total_no_of_dr_access_door_installed
      t.string   :m_total_no_of_dr_actuator_installed
      t.string   :m_total_no_of_dr_damper_installed
      t.string   :m_total_no_of_firedoor_inspected
      t.string   :m_total_no_of_firedoor_conformed
      t.string   :m_total_no_of_firedoor_nonconformed
      t.string   :m_total_no_of_firestop_surveyed
      t.string   :m_total_no_of_firestop_fixedonsite
      t.string   :m_total_no_of_fsi_surveyed
      t.string   :m_total_no_of_fsi_fixedonsite
      t.string   :m_containment_tent_used
      t.string   :m_base_bid_count
      t.string   :m_new_total_authorized_damper_bid
      t.string   :m_technician_name
      t.string   :m_blueprints_facility
      t.string   :m_replacement_checklist
      t.string   :m_facility_items
      t.string   :m_emailed_reports
      t.string   :m_daily_basis
      t.text     :m_authorization_signature_base64, :limit => 4294967295
      t.attachment :m_authorization_signature
      t.timestamps null: false
    end
  end
end
