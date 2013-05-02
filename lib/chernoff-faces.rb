
##
#  Creates chernoff face graphs in SVG.
#
module ChernoffFaces

  class Face
    ##
    # Draw a face

    def initialize

    end
  end


  ##
  # Features express values on size or shape
  # TODO: color?
  #
  class Feature
    def draw
      raise NotImplementedError('Draw should be overriden in the concrete class.')
    end
  end

  ##
  # smaller <-> larger
  #
  class Eyes < Feature
    def draw

    end
  end

  ##
  # frown <-> smile
  #
  class Mouth < Feature
    def draw

    end
  end

  ##
  # smaller <-> larger
  #
  class Ears < Feature
    def draw

    end
  end

  ##
  # oval <-> round
  #
  class HeadShape < Feature
    def draw

    end
  end

end
