require 'spec_helper'
module ChernoffFaces

  describe Feature do

    before :each do
      @canvas = Canvas.new
      @face = Face.new(@canvas,  eyes: 3, nose: 10, mouth: 5, ears: 10, head: 5 )
      @face.draw
      @doc = Nokogiri::XML(@face.to_s).slop!
    end

    it 'draws features' do
      fun_elements(@doc).should eq ["circle", "circle", "ellipse", "circle", "circle", "ellipse"]
    end
  end


end
