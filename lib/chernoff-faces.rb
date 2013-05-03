require 'rasem'
class String
  def constantize
    Object.const_get(self)
  end
end
##
#  Creates chernoff face graphs in SVG.
#
module ChernoffFaces

  ##
  # Draw a face
  # TODO: handle negative values by normalizing
  #
  class Face
    attr_reader :features

    def initialize(width = 100, height = 100, filepath = 'tmp/outfile.svg', keyvalues)
      @svg = Rasem::SVGImage.new(width, height)
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
      @svg.close
      begin
        File.open(File.expand_path(filename), 'w') { |f| f << @svg.output }
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

    def output
      @svg.output
    end


    private
    def constantize(key)
      klass = case key
              when :eyes then Eyes
              when :ears then Ears
              when :mouth then Mouth
              when :nose then Nose
              end
    end



  end
  ##
  # Features express values on size or shape
  # TODO: color? line thickness?
  #
  class Feature
    attr_accessor :svg, :values
    def initialize(svg, *values)
      @svg = svg
      @values = values
    end

    ##
    # Draw the feature
    #
    def draw
    end

    def output
      @svg.output
    end
  end

  ##
  # smaller <-> larger
  #
  class Nose < Feature
    def draw
      center = 50
      top = 10
      bottom = top + @values.first * 3
      line_length = @values.first
      # eyebrow
      @svg.line(center - line_length, top, center + 5, top)
      # nose height
      @svg.line(center + 5, top, center, bottom)
      # nose bottom
      @svg.line(center + line_length, bottom, center, bottom)
      super
    end
  end

  ##
  # smaller <-> larger
  #
  class Eyes < Feature
    def draw
      @svg.circle(30, 20, @values.first)
      @svg.circle(70, 20, @values.first)
      super
    end
  end

  ##
  # frown <-> smile
  #
  class Mouth < Feature
    def draw
      spot = 60
      center = 50
      value = @values.first * 2
      @svg.with_style :fill=>"white", :stroke=>"black" do
        polyline(center - value, spot - (value / 2), center, spot, center + value, spot + value)
      end
      super
    end
  end

  ##
  # smaller <-> larger
  #
  class Ears < Feature
    def draw
      super
    end
  end

  ##
  # oval <-> round
  #
  class HeadShape < Feature
    def draw
      super
    end
  end



end
