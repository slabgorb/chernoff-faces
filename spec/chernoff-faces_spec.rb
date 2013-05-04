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


  describe Face do

    before :each do
      @face = Face.new({ eyes: 3, nose: 10, mouth: 5, ears: 10 })
    end

    it 'creates features' do
      @face.features.map(&:last).map(&:class).should eq([ChernoffFaces::Eyes,
                                                         ChernoffFaces::Nose,
                                                         ChernoffFaces::Mouth,
                                                         ChernoffFaces::Ears])
    end

    it 'saves face' do
      path = 'tmp/test.svg'
      @face.draw.save(path)
      File.exists?(path).should be_true
    end
    it 'scales' do
      path = 'tmp/scale.svg'
      Face.new(500, 500, eyes: 3, nose: 10, mouth: 5, ears: 10 ).draw.save path
      File.exists?(path).should be_true
    end

    context 'edge cases' do
      it 'handles extreme cases' do
        ugly_small = Face.new({ eyes: 1, nose: 1, mouth: 1, ears: 1, head: 1})
        ugly_small.save('tmp/ugly_small.svg').should be_true
        ugly_big = Face.new({ eyes: 10, nose: 10, mouth: 10, ears: 10})
        ugly_big.save('tmp/ugly_big.svg').should be_true
      end
    end

    it 'outputs svg directly' do
      doc = Nokogiri::parse(@face.to_s)
      doc.children.children[1].attributes.values.map(&:value).should eq ["black", "black", "stroke: black; stroke-width: 1; fill: rgba(1,1,1,0)", "20", "4.5", "30.0"]
    end

    after :all do
      # `rm tmp\*`
    end

  end

  describe Feature do

    before :each do
      @face = Face.new({ eyes: 3, nose: 10, mouth: 5, ears: 10, head: 5 })
      @face.draw
      @doc = Nokogiri::XML(@face.to_s)
    end

    it 'draws noses' do
      @doc.children.children[5].attributes.values.map(&:value).should eq ["white", "black", "40", "10", "55", "10"]
    end
    it 'draws eyes' do
      @doc.children.children[1].attributes.values.map(&:value).should eq ["black", "black", "stroke: black; stroke-width: 1; fill: rgba(1,1,1,0)", "20", "4.5", "30.0"]
    end

  end
end
