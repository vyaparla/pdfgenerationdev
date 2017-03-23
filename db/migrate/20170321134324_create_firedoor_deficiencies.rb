class CreateFiredoorDeficiencies < ActiveRecord::Migration
  def change
    create_table :firedoor_deficiencies do |t|
      t.string   :firedoor_service_sysid
      t.string   :firedoor_asset_sysid
      t.string   :firedoor_deficiencies_sysid
      t.string   :firedoor_deficiencies_code
      t.string   :firedoor_deficiencies_codename
      t.boolean  :firedoor_u_active, :default => true
      t.boolean  :firedoor_u_delete, :default => false
      t.timestamps null: false
    end
  end
end
