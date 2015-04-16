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

if File.exists?(ARGV[1])
  puts "A file by the name of '#{ARGV[1]}' already exists. Are you sure you want to overwrite it? Confirm with 'Yes', otherwise program will terminate."
  input = $stdin.gets.chomp
  if input != "Yes"
    abort("Cancelled.")
  end
end

this_cracker = Cracker.new(infile_text, ARGV[2])
if this_cracker.forcibly_reforge_key == "ATTEMPT FAILED"
  abort("Attempt failed. The date may be incorrect, or the message may not be able to be cracked.")
end
this_decryptor = Decryptor.new(infile_text, this_cracker.cracked_key.keystr, ARGV[2])

outfile = File.new(ARGV[1], "w")
outfile << this_decryptor.decrypt
puts "Created '#{ARGV[1]}' with cracked key #{this_decryptor.key.keystr} and date #{this_decryptor.key.keydate}"
outfile.close