module ApplicationHelper

  def firedoor_deficiency_codes(fddc)
  	@codes = FiredoorDeficiency.where(:firedoor_service_sysid => fddc.u_service_id, :firedoor_asset_sysid => fddc.u_asset_id).collect { |w| w.firedoor_deficiencies_code }.join(", ")
    return @codes
  end
end
