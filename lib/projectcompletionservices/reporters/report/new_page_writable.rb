module Report
  module NewPageWritable
  	def write(pdf)
  	  start_new_page(pdf)
    end

  private

    # def bottom_margin
    #   #200
    #   350
    # end

    def background_path
      "#{Rails.root}/lib/pdf_generation/report_assets/" + projectcompletion_template
    end

    def draw_background(pdf)
      size = [612.0, 792.0]
      #size = [650.0, 800.0]
      pdf.image background_path, :fit => size, :at  => [-pdf.bounds.absolute_left, size.last - pdf.bounds.absolute_bottom]	
    end

    def start_new_page(pdf)
      pdf.start_new_page
      draw_background(pdf)
      draw_header(pdf)
      draw_footer(pdf) if respond_to?(:draw_footer, true)
    end

    def draw_header(pdf)
      pdf.move_down 78
      pdf.font_size 15
      #pdf.text_box("Project Completion", :at => [0, 470], :style => :bold) old
      #pdf.text_box("Project Completion", :at => [0, 635], :style => :bold) new
      pdf.text_box("Project Completion", :at => [0, 660], :style => :bold)
      #pdf.text_box("Date : #{project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [420, 470]) old
      #pdf.text_box("Date : #{project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [420, 635]) new
      pdf.text_box("Date : #{project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [420, 660])
      pdf.stroke_horizontal_rule
    end

    def draw_footer(pdf)
      pdf.move_down 578
      pdf.font_size 10
      pdf.stroke_horizontal_rule
      pdf.text_box("Submitted by #{project.m_technician_name}" + " at #{project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [0, 60])
      string = "Page : <page>"
      options = { :at => [pdf.bounds.right - 170, 60],
      :width => 170,
      :align => :right, :size => 10, 
      :start_count_at => 1}
      pdf.number_pages string, options
      pdf.text_box("Captured at #{project.m_date.localtime.strftime(I18n.t('time.formats.mdY'))}", :at => [0, 48])
      pdf.text_box("Job Id: #{project.m_job_id}", :at => [0, 36])
    end
  end
end