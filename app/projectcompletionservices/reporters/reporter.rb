class Reporter
  include FileWritable

  private

  def generate(file, &block)
  	make_directory(file)
    Prawn::Document.generate(file, { :skip_page_creation => true }) do |pdf|
      pdf.font_families.update("Helvetica" => {
        :normal       => font_file,
        :italic       => font_file('Oblique'),
        :bold         => font_file('Bold'),
        :bold_italic  => font_file('BoldOblique'),
        :light        => font_file('Light'),
        :light_italic => font_file('LightOblique')
      })

      pdf.default_leading 3
      block.call(pdf)
    end
  end

  def font_file(ending = '')
    File.expand_path("lib/pdf_generation/fonts/Helvetica#{ending}.ttf")
  end
end
