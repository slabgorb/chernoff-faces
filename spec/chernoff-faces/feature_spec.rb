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
      @doc.slop!.children.children.map(&:name).should eq ["text", "g", "text",
                                                          "line", "text",
                                                          "line", "text",
                                                          "line", "text",
                                                          "path", "text",
                                                          "circle", "text",
                                                          "circle", "text",
                                                          "ellipse", "text", "g",
                                                          "text", "line", "text",
                                                          "line", "text", "line",
                                                          "text", "path", "text",
                                                          "circle", "text",
                                                          "circle", "text",
                                                          "ellipse", "text"]
    end
  end


end
