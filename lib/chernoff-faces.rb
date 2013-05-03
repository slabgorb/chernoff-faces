
##
#  Creates chernoff face graphs in SVG.
#
module ChernoffFaces

  class Face
    ##
    # Draw a face
    #
    def initialize(width, height, keyvalues)
      @svg = Rasem::SVGImage.new(width, height)
      @features = { }
      key.each do |key, values|
        klass = key.to_s.capitalize.constantize
        klass.new(*values)
      end
    end
  end

  ##
  # Features express values on size or shape
  # TODO: color? line thickness?
  #
  class Feature
    def initialize(*values)
      @values = values
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
