require_relative 'key'
require_relative 'rotator'

class Encryptor
  attr_reader :key, :rotator, :text

  def initialize(text, keynum = nil, keydate = nil)
    @text = text
    @key = Key.new(keynum, keydate)
    @rotator = Rotator.new(key)
  end

  def encrypt
    rotator.rotate_forwards(text)
  end
end