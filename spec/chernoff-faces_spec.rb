require 'spec_helper'

module ChernoffFaces

  describe Face do

    before :each do
      @face = Face.new({ eyes: 3, mouth: 10 })
    end

    it 'creates features' do
      @face.features.map(&:last).map(&:class).should eq([ChernoffFaces::Eyes, ChernoffFaces::Mouth])
    end

    it 'saves face' do
      path = 'tmp/test.svg'

      @face.draw.save(path)
      File.exists?(path).should be_true
    end

    it 'outputs svg directly' do
      @face.draw.output.should match(/cx="25" cy="25" r="3"/)
    end

    after :all do
      # `rm tmp\*`
    end

  end

  describe Feature do

    before :each do
      @face = Face.new({ eyes: 3, nose: 10 })
      @face.draw
    end

    it 'draws features' do
      feature =  @face.features[:eyes]
      # one eye
      feature.svg.output.should match(/cx="25" cy="25" r="3"/)
    end

  end
end
