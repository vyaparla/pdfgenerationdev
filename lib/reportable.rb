module Reportable
  def has_full_report?
    File.exists?(full_report_path)
  end
end