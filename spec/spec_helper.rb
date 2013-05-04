require File.expand_path('lib/chernoff-faces.rb')
require 'nokogiri'


def fun_elements(noko)
  noko.slop!.children.children.map(&:name).reject{ |r| ['text', 'g'].index(r) }
end
