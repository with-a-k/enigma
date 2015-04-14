class Key
  attr_reader :keystr, :keydate, :revolver

  def initialize(keystr = generate, keydate = todaystring)
    @keystr = keystr.to_s
    @keydate = keydate
    create_revolver
  end

  def create_revolver
    @revolver = (0...4).map { |i| rotations[i] + offsets[i] }
  end

  def generate
    keystring = (0...5).map { rand(9) }.join
  end

  def todaystring
    keydate = Time.now.strftime("%d%m%y")
  end

  def rotations
    keystr.chars.each_cons(2).map(&:join).map(&:to_i)
  end

  def offsets
    squaretime = keydate.to_i**2
    squaretime.to_s.each_char.map(&:to_i).last(4)
  end
end