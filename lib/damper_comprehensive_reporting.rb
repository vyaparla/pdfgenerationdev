module DamperComprehensiveReporting
  def self.translate(key)
    I18n.t("ui.repair_report_pdf.report_data_pages.#{key}")
  end

  def self.column_heading(key)
    I18n.t("ui.repair_report_pdf.table_headings_cols.#{key}")
  end
end