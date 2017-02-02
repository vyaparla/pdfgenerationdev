module DoorInspectionReport
  class DoorScorePage
  	include Report::PageWritable

  private

    def relative_background_path
      'three_hundred_dpi/door_score_explanation.jpg'
    end
  end
end