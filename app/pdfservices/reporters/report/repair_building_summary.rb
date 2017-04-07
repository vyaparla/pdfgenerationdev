module Report
  class RepairBuildingSummary
  	include RepairSummaryDrawable

    def initialize(owner, building)
      @owner = owner
      @building = building
    end

  private
  
    def building
      @building
    end

    def title
      I18n.t('ui.inspection_report_pdf.building_summary_page.title')
    end

    def summary_table_headings
      table_column_headings(:floor)
    end
  end
end