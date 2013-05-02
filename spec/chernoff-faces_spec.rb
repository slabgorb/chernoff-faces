require 'spec_helper'

describe ChernoffFaces do
  describe Face do
    before :all do
      @face = ChernoffFaces::Face.new(100,100, { eye: -3, mouth: 10 })
    end
    it 'creates features' do
      @face.features.should eq{ }
    end
  end

  describe Feature do

  end


end
