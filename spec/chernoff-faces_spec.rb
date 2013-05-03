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
    end

    it 'draws noses' do
      @face.output.should match(/line x1="60" y1="40" x2="50" y2="40" style="stroke:black;"/)
    end
    it 'draws eyes' do
      @face.output.should match(/cx="30" cy="20" r="3"/)
    end

  end
end
