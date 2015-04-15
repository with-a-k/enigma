require_relative 'key'
require_relative 'decryptor'

class Cracker
  attr_reader :text, :character_map, :date, :cracked_key

  def initialize(text, date)
    @character_map = [*('a'..'z'), *('0'..'9'), ' ', '.', ',']
    @text = text
    @date = date
    @seam = "..end.."
    @revolver = []
    @cracked_key = nil
  end

  def retrieve_revolver
    ending = text[-7..-1]
    @revolver = ending.chars.each_with_index.map { |char, index| character_map.find_index(char) - character_map.find_index(@seam[index]) }
    correct
    shorten
  end

  def correct
    @revolver.map! do |rotation|
      if rotation < 0
        rotation + character_map.length
      else
        rotation
      end
    end
    @revolver = [0, 0, 0, 0] if @revolver[1] != @revolver[5]
  end

  def shorten
    #if text length %4 == 3 no r [. . e n d . .]
    #                             0 1 2 3 0 1 2
    # == 0 rotate 3 to the right [. . e n d . .]
    #                             1 2 3 0 1 2 3
    # == 1 rotate 2 to the right [. . e n d . .]
    #                             2 3 0 1 2 3 0
    # == 2 rotate 1 to the right [. . e n d . .]
    #                             3 0 1 2 3 0 1
    @revolver = @revolver.first(4)
    @revolver.rotate!((3-(text.length%4)))
  end

  def reconstruct_key
    retrieve_revolver
    rotations = (0...4).map { |i| @revolver[i] - grab_offsets[i] }
    while digits_mismatch?(rotations) != nil
      rotations[digits_mismatch?(rotations) + 1] += 39
      break if rotations.any? { |number| number >= 100}
    end
    return "ATTEMPT FAILED" if rotations.any? { |number| number >= 100}
    @cracked_key = Key.new(compress_key(rotations), date)
  end

  def digits_mismatch?(rotations)
    (0...3).find_index { |i| rotations[i].to_s[1] != rotations[i+1].to_s[0] }
  end

  def grab_offsets
    squaretime = date.to_i**2
    squaretime.to_s.each_char.map(&:to_i).last(4)
  end

  def compress_key(rotations)
    rotations.reduce("") do |memo, number|
      memo + number.to_s[0]
    end + rotations.last.to_s[1]
  end
end