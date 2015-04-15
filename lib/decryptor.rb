require_relative 'key'
require_relative 'rotator'

class Decryptor
  attr_reader :key, :rotator, :text

  def initialize(text, keynum, keydate)
    @text = text
    @key = Key.new(keynum, keydate)
    @rotator = Rotator.new(key)
  end

  def decrypt
    rotator.rotate_backwards(text)
  end
end