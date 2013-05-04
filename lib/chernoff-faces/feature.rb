require 'nokogiri'

module ChernoffFaces
  ##
  # Features express values on size or shape
  # TODO: color? line thickness?
  #
  class Feature
    attr_accessor :svg, :values
    def initialize(svg, *values)
      @svg = svg
      @values = values.map{ |m| m * (@svg.width / 100)}
    end

    ##
    # Draw the feature
    #
    def draw
    end

    def output
      @svg.output
    end

    def first_value
      @values.first
    end
  end

  ##
  # smaller <-> larger
  #
  class Nose < Feature
    def draw
      center = (@svg.width / 2)
      top = (@svg.height / 10)
      bottom = top + (first_value * 4)
      line_length = first_value
      # eyebrow
      @svg.line(x1: center - line_length, y1: top, x2: center + 5, y2: top)
      # nose height
      @svg.line(x1: center + 5, y1: top, x2: center, y2: bottom)
      # nose bottom
      @svg.line(x1: center + line_length, y1: bottom, x2: center, y2: bottom)
      super
    end
  end

  ##
  # smaller <-> larger
  #
  class Eyes < Feature
    def draw
      attributes = { style: "stroke: black; stroke-width: 1; fill: rgba(1,1,1,0)", cy: 20, r: first_value * 1.5}
      @svg.circle(attributes.merge({cx:(@svg.height * 0.30)}))
      @svg.circle(attributes.merge({cx:(@svg.height * 0.70)}))
      super
    end
  end

  ##
  # frown <-> smile
  #
  class Mouth < Feature
    def draw
      spot = (@svg.height * 0.60)
      center = (@svg.width * 0.50)
      value = first_value * 3
      @svg.path(fill: 'white',
                stroke: 'black',
                d:"M#{center - value},#{spot} C#{center - value},#{spot + value} #{center + value}, #{spot + value / 2} #{center + value}, #{spot} Z")
      super
    end
  end

  ##
  # smaller <-> larger
  #
  class Ears < Feature
    def draw
      y = (@svg.height * 0.40)
      x1 = (@svg.width * 0.25)
      x2 = (@svg.width * 0.75)
      radius = (first_value * 0.5)
      attributes = { style: "stroke: black; stroke-width: 10; fill: rgba(1,1,1,0)"}
      @svg.circle( attributes.merge( { cx: x1, cy: y } ) )
      @svg.circle( attributes.merge( { cx: x2, cy: y } ) )
      super
    end
  end

  ##
  # oval <-> round
  #
  class Head < Feature
    def draw
      @svg.ellipse( cx: (@svg.height * 0.50),
                    cy: (@svg.height * 0.50),
                    r1: (@svg.height * 0.50),
                    r2: (@svg.height * 0.50) - first_value,
                    style: "stroke: black; stroke-width: 10; fill: rgba(1,1,1,0)" )
      super
    end
  end



end
