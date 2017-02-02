module Report
  class BackPage
    include PageWritable

  private

    def relative_background_path
      'three_hundred_dpi/final_back_cover_new.jpg'
    end
  end
end