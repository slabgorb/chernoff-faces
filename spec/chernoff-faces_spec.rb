require 'spec_helper'

module ChernoffFaces

  describe Face do
    before :all do
      @face = Face.new(100,100, { eyes: -3, mouth: 10 })
    end
    it 'creates features' do
      @face.features.map(&:last).map(&:class).should eq([ChernoffFaces::Eyes, ChernoffFaces::Mouth])
    end


  end

  describe Feature do
    before :all do
      @face = Face.new(100,100, { eyes: -3, mouth: 10 })
    end
    it 'draws features' do
      @face.features.first.last.draw.should eq(nil)
    end
  end

end
