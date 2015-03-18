# loading and manipulating sound files.

Dir.chdir "/users/joshuajordan/dev/MusicVisualiser"

require 'ruby-audio'
require 'ffmpeg'
require 'fftw3'
require 'byebug'


include RubyAudio

class FrequencyAnalyses
    def initialize(wave_file)
        # Read the wav file this also gives information on how the source was sampled
        @snd_wave = Sound.open(wave_file)

        byebug
    end
    
    def sample_at_time(time)
        
    end
    
    def produce_amplitudes_from_fft(fft)
       
       return array 
    end
    
    def fft_on_windowed_sample(sample)
        fft = Array.new(WINDOW_SIZE/2,[])
        na = NArray.to_na(sample.to_a)
        fft_slice = FFTW3.fft(na).to_a[0, window_size/2]
        j=0
        fft_slice.each { |x| fft[j] << x; j+=1 }
    end
end

FrequencyAnalyses.new('data/200Hz.wav')
print 'll'

# We want to do a fast fourier transform on a wav file at a particular time. We sample one window (and maybe the next couple for latency)
# and then return the frequencies and there amplitudes for that sample

#File.open('data/wav.txt', 'w') { |file| file.write(fft) }
