require 'spec_helper'

module ChernoffFaces

  describe Face do
    before :all do
      @face = Face.new({ eyes: 3, mouth: 10 })
    end
    it 'creates features' do
      @face.features.map(&:last).map(&:class).should eq([ChernoffFaces::Eyes, ChernoffFaces::Mouth])
    end


  end

  describe Feature do
    before :each do
      @face = Face.new({ eyes: 3, mouth: 10 })
    end
    it 'draws features' do
      feature =  @face.features[:eyes]
      feature.draw
      feature.svg.output.should match(/cx="25" cy="25" r="3"/)
      feature.svg.output.should match(/cx="25" cy="75" r="3"/)
    end
  end

end
