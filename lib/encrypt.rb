#encrypt.rb
#ARGV[0] should be the INfile name
#ARGV[1] should be the OUTfile name
require_relative 'key'
require_relative 'encryptor'
require_relative 'rotator'

infile = File.new(ARGV[0], "r")
infile_text = infile.read.downcase.gsub(/[^a-z0-9,. ]/, ' ')
infile.close

this_encryptor = Encryptor.new(infile_text)

outfile = File.new(ARGV[1], "w")
outfile << this_encryptor.encrypt
puts "Created '#{ARGV[1]}' with key #{this_encryptor.key.keystr} and date #{this_encryptor.key.keydate}"
outfile.close