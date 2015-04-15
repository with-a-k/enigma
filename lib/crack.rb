#crack.rb
#ARGV[0] should be the INfile name
#ARGV[1] should be the OUTfile name
#ARGV[2] should be the DATE STRING
require_relative 'key'
require_relative 'decryptor'
require_relative 'cracker'
require_relative 'rotator'

puts "You need to supply a date!" if ARGV[2] == nil
return if ARGV[2] == nil

infile = File.new(ARGV[0], "r")
infile_text = infile.read.downcase.gsub(/[^a-z0-9,. ]/, ' ')
infile.close

this_cracker = Cracker.new(infile_text, ARGV[2])
this_cracker.reconstruct_key
this_decryptor = Decryptor.new(infile_text, this_cracker.cracked_key.keystr, ARGV[2])

outfile = File.new(ARGV[1], "w")
outfile << this_decryptor.decrypt
puts "Created '#{ARGV[1]}' with cracked key #{this_decryptor.key.keystr} and date #{this_decryptor.key.keydate}"
outfile.close