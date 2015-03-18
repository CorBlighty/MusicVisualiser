# This file deals with the apinting of the frequencies onto the canvas

#!/usr/bin/env ruby
Dir.chdir "/users/joshuajordan/dev/MusicVisualiser"
require 'rvg/rvg'

include Magick            
            
RVG::dpi = 72

class Painter
    attr_accessor :drawing, :current_line, :image
    attr_reader :lines

    module FREQUENCYS
        bass = 'blue'
        mid = 'red'
        treble = 'yellow'
    end
    
    def initialize(width, height)
       @width = width
       @height = height
       @drawing = FALSE
       @pieces = []
       @background_image = Magick::Image.read("data/2.png").first
       @current_frequency = 'blue'
       
       @rvg = RVG.new(width, height).viewbox(0,0,width,height) do |canvas|
           canvas.background_image = @background_image
       end
       
       @image = @rvg.draw    
    end
    
    def on_button_down(id)
        case id
        when Gosu::MsLeft
            @current_line = PaintedLine.new(@current_frequency)
            @drawing = TRUE
        end
    end
    
    def on_button_up(id)
        case id
        when Gosu::MsLeft
            @drawing = FALSE
            @pieces << Piece.new(@current_frequency, @current_image, @rvg)
        end
    end

    def decrease_frequency
    end

    def increase_frequency
    end
    
    def update_image
        if drawing
            if not @current_line.mouse_xy.empty? 
                @current_line.draw_onto_image(@image)
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
end

class Piece
    STATES = {'start'=>1, 'middle'=>2, 'nothing'=>3}

    def initialize(frequency, painted_image, canvas_rvg)
        @state = STATES['nothing']
        @frequency = frequency
        @painted_image = painted_image
    end

    def on_update

    end

    def draw_onto_image(image)
        @painted_image.rvg.draw(image)
    end
end

class PaintedImage
    attr_reader :rvg

    def initialize(colour)
        @colour = colour
    end

    def on_activation(amplitude)

    end

    def update_rvg

    end

    def draw_preview(iamge)
    end
end

class PaintedLine < PaintedImage
    attr_reader :mouse_xy

    def initialize(colour)
        super(colour)
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

    def draw_preview(image)
        create_rvg
        @rvg.draw(image)
    end

    def create_rvg
        @rvg = RVG::Draw.new
        @rvg.stroke_width(@stroke_size)
        @rvg.stroke(@colour)
        @rvg.fill('none')
        @rvg.polyline(*@mouse_xy) 
    end
end






