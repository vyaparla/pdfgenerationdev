module DoorInspectionReport
  class GraphGenerator
    include FileWritable

    def initialize(job)
      @job = job
    end

    def generate
      generate_firedoor_door_by_rating
    end

  private
  
    def generate_firedoor_door_by_rating
      g = Gruff::Pie.new('1333x1000')
      g.theme = {
        :marker_color => '#aaa',
        :colors => %w(#e3553f #f39d27 #94b463 #568ac6 #5e723f #8e3629 #385a81
                      #aa6d19 #e3bf42),
        :background_colors => ['#fff', '#fff']
      }
      g.font = File.expand_path('lib/pdf_generation/fonts/Helvetica.ttf', Rails.root)
      g.title_font_size = 24
      g.legend_font_size = 24
      g.marker_font_size = 24
      g.bottom_margin = 50
      g.title = 'Fire Ratings'
      g.title_margin = 50
      g.sort = false
      g.maximum_value = 100
      g.minimum_value = 0
      g.y_axis_increment = 20

      @firedoor_door_by_rating = Lsspdfasset.select(:u_fire_rating).where(:u_service_id => @job.u_service_id, :u_delete => false).where.not(u_fire_rating: "").group(["u_fire_rating"]).count(:u_fire_rating)
      @firedoor_door_by_rating_count = 0
      @firedoor_door_by_rating.each do |key, value|
        @firedoor_door_by_rating_count += value
      end
      

      @firedoor_doorbyrating_graph = []
      @firedoor_door_by_rating.each do |key, value1|
        @firedoor_doorbyrating_graph << [key, ((value1.to_f * 100 ) / @firedoor_door_by_rating_count)]
      end
      
      data = @firedoor_doorbyrating_graph
      data.each {|d| g.data d.first, d.last}
      make_directory(@job.graph_firedoor_door_by_rating_path)
      g.write(@job.graph_firedoor_door_by_rating_path)
    end
  end
end
