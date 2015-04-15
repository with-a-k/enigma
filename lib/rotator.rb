require_relative 'key'

class Rotator
  attr_reader :rotations, :character_map

  def initialize(key)
    @rotations = key.revolver
    @character_map = [*('a'..'z'), *('0'..'9'), ' ', '.', ',']
  end

  def rotate_forwards(intext)
    outtext = ""
    intext.chars.each_slice(4) do |slice|
      slice.each_with_index do |char, index|
        outtext << character_map[(character_map.find_index(char)+rotations[index])%character_map.length]
      end
    end
    outtext
  end

  def rotate_backwards(intext)
    outtext = ""
    intext.chars.each_slice(4) do |slice|
      slice.each_with_index do |char, index|
        outtext << character_map[(character_map.find_index(char)-rotations[index])%character_map.length]
      end
    end
    outtext
  end
end