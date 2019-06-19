
# Quick and dirty experimental space to match metadata b/w TW and BHL

require 'byebug'
require 'awesome_print'
require 'CSV'

a = CSV.open('data/tw/serials_2019-06-17T19_26_32+00_00.csv', col_sep:  "\t", quote_char: '"', headers: true )
b = CSV.open('data/bhl/title.txt', row_sep: "\r\n", col_sep: "\t", headers: true, liberal_parsing: true,  encoding: 'UTF-8', quote_char: "\x00" )

n1 = []
i = 0
a.each do |r|
  # puts r['name']
  n1.push r['name'].strip.downcase #.gsub!(/\.$/, '')
    i += 1
    # break if i > 100
end

puts '-----'
n2 = []

i = 0
begin
  b.each do |r|
    # puts ' -' + r['FullTitle']
    t = r['FullTitle'].strip.downcase.gsub(/[\.\,]$/, '').gsub(/\s*\/$/, '')
    # puts t
    n2.push t
    i += 1
     #  break if i > 100
  rescue CSV::MalformedCSVError
    puts "ERROR"
    next
  end
end

n1.sort!
n2.sort!

z = n2 & n1

i = 0
n1.each do |j|
  n2.each do |k|
    if k =~ /#{Regexp.escape(j)}/
      puts "found #{j}"
      i += 1
      break
    end
  end
end
puts i

# puts z.join("\n")
# puts z.size

