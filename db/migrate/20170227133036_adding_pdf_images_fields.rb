class AddingPdfImagesFields < ActiveRecord::Migration
  def change
  	add_attachment :lsspdfassets, :pdf_image1
  	add_attachment :lsspdfassets, :pdf_image2
  	add_attachment :lsspdfassets, :pdf_image3
  	add_attachment :lsspdfassets, :pdf_image4  	
  end
end
