require 'nokogiri'

##
#  Creates chernoff face graphs in SVG.
#
module ChernoffFaces

  class Canvas
    def initialize(width = 100, height = 100)
      @doc = Nokogiri::XML.parse %Q|<?xml version="1.0" standalone="no"?>
         <!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN"
         "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
           <svg xmlns="http://www.w3.org/2000/svg" version="1.1"></svg>|
      @parent = @doc.at_css "svg"
      @parent['width'] = width
      @parent['height'] = height
    end

    def self.default_style(element_type = :default)
      case element_type.to_sym
        when :line then { fill:'white', stroke:'black' }
        else { fill:'black', stroke:'black' }
      end
    end

    def child(node_type, attributes)
      node = Nokogiri::XML::Node.new node_type, @doc
      attributes = Canvas.default_style(node_type).merge(attributes)
      node.parent = @parent
      attributes.each_pair do |k,v|
        node[k] = v
      end
    end

    def method_missing(meth, opts = { })
      child(meth.to_s, opts)
    end

    def to_s
      @doc.to_s
    end

  end

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

    def first_value
      @values.first
    end
  end

  ##
  # smaller <-> larger
  #
  class Nose < Feature
    def draw
      center = 50
      top = 10
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
      @svg.circle(attributes.merge({cx: 30}))
      @svg.circle(attributes.merge({cx: 70}))
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
      value = first_value * 3
      @svg.path(fill: 'white',
                stroke: 'black',
                d:"M#{center - value},#{spot} C#{center - value},#{spot + value} #{center + value}, #{spot + value} #{center + value}, #{spot} Z")
      super
    end
  end

  ##
  # smaller <-> larger
  #
  class Ears < Feature
    def draw
      y = 40
      x1 = 25
      x2 = 75
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
      @svg.ellipse( cx: 50,
                    cy: 50,
                    r1: 50,
                    r2: 50 - first_value,
                    style: "stroke: black; stroke-width: 10; fill: rgba(1,1,1,0)" )
      super
    end
  end



end
