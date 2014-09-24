# This file deals with the apinting of the frequencies onto the canvas

#!/usr/bin/env ruby
Dir.chdir "/users/joshuajordan/dev/MusicVisualiser"
require 'rvg/rvg'

include Magick            
            
RVG::dpi = 72
            
class Painter
    attr_accessor :drawing, :current_line, :image
    attr_reader :lines
    
    def initialize(width, height)
       @width = width
       @height = height
       @drawing = FALSE
       @lines = []
       @background_image = Magick::Image.read("data/2.png").first
       
       @rvg = RVG.new(width, height).viewbox(0,0,width,height) do |canvas|
           canvas.background_image = @background_image
       end
       
       @image = @rvg.draw    
    end
    
    def on_button_down(id)
        case id
        when Gosu::MsLeft
            @current_line = PaintedLine.new
            @drawing = TRUE
        end
    end
    
    def on_button_up(id)
        case id
        when Gosu::MsLeft
            @drawing = FALSE
            @lines << @current_line
        end
    end
    
    def update_image
        if drawing
            if not @current_line.mouse_xy.empty? 
                @current_line.draw_onto_image(@image)
            end 
        end

        if not @lines.empty? and not drawing
            @lines.each do |line|
                line.change_line_colour('green', @image)
            end
        end
    end
    
    def draw_image
        @image = @rvg.draw  
    end
    
    def paint_a_point(point, colour)
        pt = RVG::Draw.new
        pt.translate(point[0], point[1])
        pt.stroke(colour)
        pt.stroke_width(2)
        pt.ellipse(18,15, 15,17, 0, 27)
        pt.rectangle(14, 12, -12, -11)
        pt.draw(@image)
    end

    def change_line_colour(line, colour)
        line.stroke(colour)
        line.draw(@image)
    end
end

class PaintedLine
    attr_reader :mouse_xy

    def initialize
        @stroke_size = 1
        @mouse_xy = []
    end

    def add_points(x, y)
        @mouse_xy << x
        @mouse_xy << y
    end

    def increase_stroke_size()
        @stroke_size *= 1.2
    end

    def decrease_stroke_size()
        @stroke_size *= 0.6
    end

    def change_line_colour(colour, image)
        rvg = RVG::Draw.new
        rvg.stroke_width(@stroke_size)
        rvg.stroke(colour)
        rvg.fill('none')

        n = []
        @mouse_xy.each do |point|
            n << point + 7
        end

        rvg.polyline(*n )
        rvg.draw(image)
    end

    def draw_onto_image(image)
        rvg = RVG::Draw.new
        rvg.stroke_width(@stroke_size)
        rvg.stroke('red')
        rvg.fill('none')
        rvg.polyline(*@mouse_xy)
        rvg.draw(image)
    end
end






