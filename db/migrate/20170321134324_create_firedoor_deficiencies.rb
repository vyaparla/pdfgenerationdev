class CreateFiredoorDeficiencies < ActiveRecord::Migration
  def change
    create_table :firedoor_deficiencies do |t|
      t.string   :firedoor_service_sysid
      t.string   :firedoor_asset_sysid
      t.string   :firedoor_deficiencies_sysid
      t.string   :firedoor_deficiencies_codes
      t.string   :firedoor_deficiencies_codes_with_name
      t.timestamps null: false
    end
  end
end
