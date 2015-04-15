#decrypt.rb
#ARGV[0] should be the INfile name
#ARGV[1] should be the OUTfile name
#ARGV[2] should be the 5-DIGIT KEY
#ARGV[3] should be the DATE STRING
require_relative 'key'
require_relative 'decryptor'
require_relative 'rotator'

puts "You need to supply a key!" if ARGV[2] == nil
return if ARGV[2] == nil

infile = File.new(ARGV[0], "r")
infile_text = infile.read.downcase.gsub(/[^a-z0-9,. ]/, ' ')
infile.close

this_decryptor = Decryptor.new(infile_text, ARGV[2], ARGV[3])

outfile = File.new(ARGV[1], "w")
outfile << this_decryptor.decrypt
puts "Created '#{ARGV[1]}' with key #{this_decryptor.key.keystr} and date #{this_decryptor.key.keydate}"
outfile.close