module ChernoffFaces

  ##
  # Draw a face
  # TODO: handle negative values by normalizing
  #
  class Face
    attr_reader :features

    def initialize(width = 100, height = 100, filepath = 'tmp/outfile.svg', keyvalues)
      @svg = Canvas.new(width, height)
      @features = { }
      keyvalues.each do |key, values|
        @features[key] = constantize(key).new(@svg, *values)
      end
      draw
    end

    ##
    # Saves the image to file
    #
    def save(filename)
      begin
        File.open(File.expand_path(filename), 'w') { |f| f << @svg.to_s }
      rescue Exception => e
        puts e.message
        return false
      end
      true
    end

    ##
    # Set or override one of the facial features
    #
    def []=(key, *values)
      @features[key] = constantize(key).new(@svg, *values)
    end

    def draw
      @features.each{ |k,f| f.draw }
      self
    end

    def to_s
      @svg.to_s
    end


    private
    def constantize(key)
      klass = case key
              when :eyes then Eyes
              when :ears then Ears
              when :mouth then Mouth
              when :nose then Nose
              when :head then Head
              end
    end



  end
end
