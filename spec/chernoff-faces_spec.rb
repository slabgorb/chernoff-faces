require 'spec_helper'

module ChernoffFaces

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

    context 'edge cases' do
      it 'handles extreme cases' do
        ugly = Face.new({ eyes: 0, nose: 0, mouth: 0, ears: 0})
      end
    end

    it 'outputs svg directly' do
      @face.draw.output.should match(/cx="30" cy="20" r="3"/)
    end

    after :all do
      # `rm tmp\*`
    end

  end

  describe Feature do

    before :each do
      @face = Face.new({ eyes: 3, nose: 10, mouth: 5, ears: 10 })
      @face.draw
      @doc = Nokogiri::XML(@face.output)
    end

    it 'draws noses' do
      @doc.children.children[5].attributes.values.map(&:value).should eq ["60", "40", "50", "40", "stroke:black;"]
    end
    it 'draws eyes' do
      @doc.children.children[1].attributes.values.map(&:value).should eq ["30", "20", "3", "stroke:black;"]
    end

  end
end
