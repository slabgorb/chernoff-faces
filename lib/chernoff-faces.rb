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
  #
  class Face
    attr_reader :features

    def initialize(width, height, keyvalues)
      @svg_image = Rasem::SVGImage.new(width, height)
      @features = { }
      keyvalues.each do |key, values|
        klass = case key
                when :eyes then Eyes
                when :ears then Ears
                when :mouth then Mouth
        end
        @features[key] = klass.new(@svg_image, *values)
      end
    end

    def draw
      @features.each(&:draw)
    end

  end
  ##
  # Features express values on size or shape
  # TODO: color? line thickness?
  #
  class Feature
    def initialize(svg_image, *values)
      @values = values
      @svg = svg_image
    end

    ##
    # Draw the feature
    #
    def draw(*values)

    end
  end

  ##
  # smaller <-> larger
  #
  class Eyes < Feature
    def draw(*values)

      super
    end
  end

  ##
  # frown <-> smile
  #
  class Mouth < Feature
    def draw(*values)
      super
    end
  end

  ##
  # smaller <-> larger
  #
  class Ears < Feature
    def draw(*values)
      super
    end
  end

  ##
  # oval <-> round
  #
  class HeadShape < Feature
    def draw(*values)
      super
    end
  end



end
