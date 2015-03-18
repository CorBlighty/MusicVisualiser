# This is the main display, it handles the top level window events and intializes the painting
# and sound components.

#!/usr/bin/env ruby
Dir.chdir "/users/joshuajordan/dev/MusicVisualiser"

require 'rubygems'
require 'gosu'
require 'Thread'
require 'byebug'
require 'pry'
require './lib/painting'
require './lib/sound'
 
include Gosu

class MainCanvas < Window
    HEIGHT = 640    
    WIDTH = 720
    TITLE = 'win'
    
    TOP_COLOR = Gosu::Color.new(0xFF1EB1FA)
    BOTTOM_COLOR = Gosu::Color.new(0xFF1A4DB5)
    
    
    def initialize
        super(WIDTH,HEIGHT,FALSE)
        self.caption = TITLE
        
        @last_frame = Gosu::milliseconds
        @increase = TRUE
        @painter = Painter.new(WIDTH, HEIGHT)
        @gosu_image = Image.new(self, @painter.image, true)
    end
    
    def update
        #calculate_delta
        update_image
    end
    
    def calculate_delta
        @this_frame = Gosu::milliseconds
        @delta = (@this_frame - @last_frame) / 1000.0
        @last_frame = @this_frame
    end
    
    def draw
        @painter.draw_image
        @gosu_image.insert(@painter.image,0,0)
        @gosu_image.draw(0,0,0)
    end
    
    def button_down(id)
        case id
        when MsLeft
            @painter.on_button_down(id)
        when KbUp
            @painter.current_line.increase_stroke_size()
        when KbDown
            @painter.current_line.decrease_stroke_size()
        when KbLeft
            @painter.decrease_frequency()
        when KbRight
            @painter.increase_frequency()
        when KbEscape
            close
        end
    end
   
    def button_up(id)
        case id
        when MsLeft
            @painter.on_button_up(id)
        end
    end
   
    def needs_cursor?; true; end
    
    def update_image        
        if @painter.drawing
            @painter.current_line.add_points(mouse_x, mouse_y)
        end
        @painter.update_image
    end
end

MainCanvas.new.show


