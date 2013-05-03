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

    def initialize(width = 100, height = 100, filename = 'outfile.svg', keyvalues)
      @svg = Rasem::SVGImage.new(width, height)
      @features = { }
      keyvalues.each do |key, values|
        klass = case key
                when :eyes then Eyes
                when :ears then Ears
                when :mouth then Mouth
        end
        @features[key] = klass.new(@svg, *values)
      end
    end

    def save(filename)

    end

    def draw
      @features.each{ |f| f.draw }
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
  end

  ##
  # smaller <-> larger
  #
  class Nose < Feature
    def draw
      @svg.line(50, 35, 50, @values.first)
      @svg.circle(40, @values.first, 50, @values.first)
      super
    end
  end

  ##
  # smaller <-> larger
  #
  class Eyes < Feature
    def draw
      @svg.circle(25, 25, @values.first)
      @svg.circle(25, 75, @values.first)
      super
    end
  end

  ##
  # frown <-> smile
  #
  class Mouth < Feature
    def draw

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
