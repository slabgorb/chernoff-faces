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

    def width
      @parent['width'].to_i
    end

    def height
      @parent['height'].to_i
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
end
