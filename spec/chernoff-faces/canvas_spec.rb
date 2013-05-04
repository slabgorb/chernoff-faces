require 'spec_helper'
module ChernoffFaces
  describe Canvas do
    before :each do
      @canvas = Canvas.new(100, 100)
    end
    it 'makes a nokogiri document with a svg header' do
      @canvas.to_s.should eq("<?xml version=\"1.0\" standalone=\"no\"?>\n<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">\n<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"100\" height=\"100\"/>\n")
    end

    it 'gets named element styles' do
      Canvas.default_style(:line).should eq({ fill:'white', stroke:'black' })
    end

    it 'gets a default element style on an unknown element' do
      Canvas.default_style(:foo).should eq({ fill:'black', stroke:'black' })
    end

    it 'gets a default element style on a nil element' do
      Canvas.default_style().should eq({ fill:'black', stroke:'black' })
    end

    it 'responds to method calls like "circle"' do
      @canvas.circle()
    end

    it 'makes a circle' do
      @canvas.circle(cx:50, cy:50, r:20)
    end

  end


end
