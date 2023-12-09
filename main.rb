# # # Day 1
# # # Read in day1.txt with Ruby
# # file = File.open("day1.txt")
# # # iterate over contents

# # word_digits = {"one" => 1, "two" => 2, "three" => 3, "four" => 4, "five" => 5, "six" => 6, "seven" => 7, "eight" => 8, "nine" => 9}

# # output_array = []
# # file.each do |line|
# #     # for each line, filter out the non-integers, unless the letters appear in sequence as keys in word_digits hash
# #     # split the line into an array of characters

# #     puts "#{num}"
    
# #     # create a new number of the first and last digit in the array
# #     # if there's only one digit, create a new number of two of that one digit (e.g. 7 = 77)
# #     new_num = nil
# #     if num.length == 1
# #         new_num = num[0].to_i * 11
# #     else
# #         new_num = num[0] + num[-1]
# #     end
# #     new_num = new_num.to_i
# #     # add the new number to the output array
# #     output_array << new_num
# # end

# # # sum the output array
# # sum = output_array.sum
# # puts sum



# map = {
#     'one' => 1,
#     '1' => 1,
#     'two' => 2,
#     '2' => 2,
#     'three' => 3,
#     '3' => 3,
#     'four' => 4,
#     '4' => 4,
#     'five' => 5,
#     '5' => 5,
#     'six' => 6,
#     '6' => 6,
#     'seven' => 7,
#     '7' => 7,
#     'eight' => 8,
#     '8' => 8,
#     'nine' => 9,
#     '9' => 9
# }
# nums = []

# file = File.open("day1.txt")
# file.each do |line|
#     word_nums = line.scan(Regexp.new("(?=(#{map.keys.join('|')}))")).flatten
#     num = (map[word_nums.first].to_s + map[word_nums.last].to_s).to_i
#     nums << num
# end
# puts nums.sum


# # # Day 2
# limits = {
#     'blue' => 14,
#     'red' => 12,
#     'green' => 13
# }
# possible_games = []
# impossible_games = []
# file = File.open("day2.txt")

# file.each do |line|
#     game_id, subsets = line.split(': ')
#     game_id = game_id.gsub('Game ', '').to_i
#     possible = true
#     subsets.split(';').each do |subset|
#     next unless possible

#     subset.split(',').each do |colour_pair|
#         next unless possible

#         num, colour = colour_pair.split
#         if num.to_i > limits[colour]
#         possible = false
#         next
#         end
#     end
#     end
#     if possible
#     possible_games << game_id
#     else
#     impossible_games << game_id
#     end
# end
# # puts possible_games.sum

# powers = {}
# file = File.open("day2.txt")

# file.each do |line|
# game_id, subsets = line.split(': ')
# game_id = game_id.gsub('Game ', '').to_i
# values = {}
# subsets.split(';').each do |subset|
#     subset.split(',').each do |colour_pair|
#     num, colour = colour_pair.split
#     values[colour] = num.to_i if values[colour].nil? || num.to_i > values[colour]
#     end
# end
# powers[game_id] = values.values.inject(:*)
# end
# puts powers.values.sum


# Day 3
# $sum = 0

# class Number
#     def initialize(me, x, y, length, lines)
#         @me, @coords, @length, @lines = me, [x, y], length, lines
#     end

#     def find_chars
#         rows = []
#         x, y = @coords
#         row_start = [x - 1, 0].max
#         row_end = [x + @length + 1, @lines[y].length].min
#         rows << @lines[y - 1][row_start...row_end] if y > 0
#         rows << @lines[y][row_start...row_end]
#         rows << @lines[y + 1][row_start...row_end] if y < @lines.length - 1

#         rows.map! { |row| row.gsub(/[\n#{@me}.]/, '') }
#         result = rows.join

#         $sum += @me.to_i if result != ''
#     end
# end

# lines = File.readlines("day3.txt")

# lastX = 0
# lastY = 0

# lines.each.with_index do |v, k|
#     v.each_char.with_index do |char, index|
#         next if k == lastY && index < lastX
#         if char =~ /\d/
#             length = 1
#             length += 1 while v[index + length] =~ /\d/
#             number = Number.new(v[index...(index + length)], index, k, length, lines)
#             number.find_chars
#             lastX = index + length
#             lastY = k
#         end
#     end
# end

# p $sum

# class Number
#     attr_reader :x, :y

#     def initialize(x, y)
#         @x = x
#         @y = y
#     end

#     def find_whole_number(line)
#         start = x
#         finish = x
#         start -= 1 while line[start - 1] =~ /[0-9]/ && start > 0
#         finish += 1 while line[finish + 1] =~ /[0-9]/ && finish < line.length - 1
#         line[start..finish]
#     end
# end

# class Gear
#     attr_reader :coords

#     def initialize(x, y)
#         @coords = [x, y]
#     end

#     def find_nums(lines)
#         x, y = coords
#         rows = []
#         nums = []
#         rows << lines[y - 1][(x - 1)..(x + 1)] if y > 0
#         rows << lines[y][(x - 1)..(x + 1)]
#         rows << lines[y + 1][(x - 1)..(x + 1)] if y < lines.length - 1
#         connections = []
#         rows.each.with_index do |row, k|
#             next unless row =~ /[0-9]/

#             if row[1] =~ /[0-9]/ && row[3] =~ /[0-9]/ && !(row[2] =~ /[0-9]/)
#                 connections << [1, (k - 1)]
#                 connections << [3, (k - 1)]
#             elsif row[1] =~ /[0-9]/ && row[2] =~ /[0-9]/ && !(row[3] =~ /[0-9]/)
#                 connections << [1, (k - 1)]
#             else
#                 row.each_char.with_index do |char, i|
#                     connections << [(i - 1), (k - 1)] if char =~ /[0-9]/ && (connections.empty? || connections[-1][0] != (i - 2))
#                 end
#             end
#         end
#         if connections.size == 2
#             connections.each do |connection|
#                 nx = x + connection[0]
#                 ny = y + connection[1]
#                 number = Number.new(nx, ny)
#                 nums << number.find_whole_number(lines[ny])
#             end
#             $sum += (nums[0].to_i * nums[1].to_i)
#         end
#     end
# end

# lines = File.open("day3.txt", "r") do |file|
#     file.readlines
# end

# $sum = 0

# lines.each.with_index do |v, k|
#     v.each_char.with_index do |char, index|
#         if char == "*"
#             gear = Gear.new(index, k)
#             gear.find_nums(lines)
#         end
#     end
# end

# puts $sum

# Day 4
# file = File.open("day4.txt")
# points = 0

# file.each do |line|
#     point_multiplier = false
#     inner_points = 0

#     winning_numbers, owned_numbers = line.split("|").map { |side| side.split.map(&:to_i) }
#     winning_numbers.shift(2)

#     owned_numbers.each do |num|
#         if winning_numbers.include?(num) && !point_multiplier
#             inner_points += 1
#             point_multiplier = true
#         elsif winning_numbers.include?(num) && point_multiplier
#             inner_points *= 2
#         end
#     end

#     points += inner_points
#     inner_points = 0
#     point_multiplier = false
# end

# puts points


# scores = {}
# file = File.open("day4.txt")
# file.each do |line|
#     card_id_string, numbers = line.split(': ')
#     _, card_id = card_id_string.split
#     scores[card_id.to_i] = { score: 0, count: 1 }

#     winning_numbers, our_numbers = numbers.split(' | ')
#     winning_numbers = winning_numbers.split.map(&:to_i)
#     our_numbers = our_numbers.split.map(&:to_i)

#     winning_number_count = winning_numbers.count
#     remaining_number_count = (winning_numbers - our_numbers).count
#     matched_number_count = winning_number_count - remaining_number_count

#     scores[card_id.to_i][:score] = matched_number_count
# end

# scores.each do |key, value|
#     value[:count].times do
#         ((key + 1)..key + value[:score]).each do |idx|
#         scores[idx][:count] = scores[idx][:count] + 1
#         end
#     end
# end

# puts scores.values.map { |x| x[:count] }.sum


# Day 5
# class Mapping
#     attr_reader :src, :dest
  
#     def initialize(src, dest)
#       @src, @dest = [src, dest].map(&:to_sym)
#       @ranges = []
#     end
  
#     def add_range(dest_start, src_start, length)
#       @ranges << [
#         (src_start...(src_start + length)),
#         (dest_start...(dest_start + length)),
#       ]
#     end
  
#     def map(number)
#       if range = @ranges.find { |(s, _)| s.cover?(number) }
#         src_range, dest_range = range
#         dest_range.begin + (number - src_range.begin)
#       else
#         number
#       end
#     end
#   end
  
#   almanac = []
#   seeds = []
  
#   File.open(File.join(__dir__, 'day5.txt'), 'r') do |file|
#     line = file.readline.chomp
#     seeds = line[7..].split(/\s+/).map(&:to_i)
#     file.readline
  
#     until file.eof?
#       line = file.readline.chomp
#       _, source, destination = /(\w+)-to-(\w+)/i.match(line).to_a
  
#       mapping = Mapping.new(source, destination)
#       almanac << mapping
  
#       loop do
#         line = file.readline.chomp
#         break if /\A\s*\z/.match?(line) || file.eof?
  
#         dest_start, src_start, length = line.split(/\s+/).map(&:to_i)
#         mapping.add_range(dest_start, src_start, length)
#       end
#     end
#   end
  
#   locations = seeds.map do |seed|
#     almanac.reduce(seed) { |seed, mapping| mapping.map(seed) }
#   end
  
#   puts locations.min


# # Part 2
# require 'pp'
 
# Seeds = Struct.new(:start, :length)
# Entry = Struct.new(:dest, :src, :range) do
#   def src_first() src end
#   def src_last() src + range end
#   def dest_last() dest + range end
# end
# Map = Struct.new(:from, :to, :entries)
 
# seed_ranges = []
# maps = []
 
# fin = File.open(ARGV[0] || 'day5.txt')
# while (line = fin.gets)
#   case line
#   when /^seeds: ([\d ]+)/
#     ary = $1.split().map(&:to_i)
#     i = 0
#     while i < ary.length
#       seed_ranges << Seeds.new(ary[i], ary[i+1])
#       i += 2
#     end
#   when /^(\w+)-to-(\w+) map:/
#     from, to = $1.to_sym, $2.to_sym
#     ary = []
#     while fin.gets =~ /\s*(\d+)\s+(\d+)\s+(\d+)/
#       ary << Entry.new($1.to_i, $2.to_i, $3.to_i)
#     end
#     maps << Map.new(from, to, ary)
#   when /\s*\r?\n/
#     # ignore blanks
#   else
#     raise "Unmatched line #{line.inspect}"
#   end
# end
 
# #pp seed_ranges
# #pp maps
 
# ranges = seed_ranges.map do |seeds|
#   seeds.start...seeds.start+seeds.length
# end.sort_by!(&:first).reverse!
 
# from = :seed
# map_i = 0
# while map_i < maps.length
#   map = maps[map_i]
#   ents = map.entries.sort_by(&:src).reverse!
 
# #   puts "#{map.from} ranges #{ranges.inspect}"
 
#   next_ranges = []
#   while (range = ranges.pop)
#     # puts "  range: #{range.inspect}"
 
#     a, b = range.first, range.last
 
#     # skip map entries ranging completely below range start
#     ents.pop while ents.length > 0 && ents[-1].src_last <= a
 
#     if ents.length > 0
#       ent = ents[-1]
#       off = ent.dest - ent.src
#     #   puts "  ent: #{ent.inspect} #{ent.src_first}...#{ent.src_last} -> #{ent.dest}...#{ent.dest_last}"
 
#       if a < (sf = ent.src_first) # range starts before map entry
#         if b < sf # range ends before map entry
#           # add whole range as direct map (identity)
#           next_ranges << (a...b)
#         else # range ends in or after map entry
#           # add first part of range as direct map
#           next_ranges << (a...sf)
#         #   puts "    (split) #{a}...#{sf}"
#           # enqueue remaining range
#           ranges << (sf...b)
#         end
#       else # range starts inside map entry
#         sl = ent.src_last
#         if b <= sl # range ends inside map entry
#           # add whole range mapped by offset
#           next_ranges << (a+off...b+off)
#         #   puts "    #{a}...#{b} -> #{a+off}...#{b+off}"
#         else # range ends after map entry
#           # add first part of range offseted
#           next_ranges << (a+off...sl+off)
#         #   puts "    #{a}...#{b} -> (split) #{a+off}...#{sl+off}"
#           # enqueue remaining range
#           ranges << (sl...b)
#         end
#       end
#     else
#       # range maps directly
#       next_ranges << range
#     end
#   end
 
#   ranges = next_ranges.sort_by(&:first)
 
#   # merge ranges - neat but doesn't speed things up appreciably
#   i = 0
#   while (j = i + 1) < ranges.length
#     if ranges[i].last >= ranges[j].first # overlap
#       if ranges[i].last <= ranges[j].last # but [j] is not a subset of [i]
#         ranges[i] = ranges[i].first...ranges[j].last # merge
#       end
#       ranges.delete_at(j)
#     else # nothing to merge, advance
#       i = j
#     end
#   end
#   ranges.reverse! # so we can .pop instead of .shift
 
#   map_i += 1
# end
 
# # puts "\nfinal ranges #{ranges.reverse.inspect}"
 
# puts ranges[-1].first

# Day 6
# INPUT = 'day6.txt'

# def times
#   File.readlines(INPUT)[0].split.drop(1).map(&:to_i)
# end

# def distances
#   File.readlines(INPUT)[1].split.drop(1).map(&:to_i)
# end

# def time
#   File.readlines(INPUT)[0].gsub('Time:', '').gsub(' ', '').to_i
# end

# def distance
#   File.readlines(INPUT)[1].gsub('Distance:', '').gsub(' ', '').to_i
# end

# # return an array containing ranges of every winning time for each race by zipping
# def get_all_winning_times(times, distances)
#   races = []
#   times.zip(distances).each do |race|
#     races.push(get_winning_times(race[0], race[1]))
#   end
#   races
# end

# # get the winning times
# # this is the quadratic formula, but i fucked it up beyond recognition to satisfy rubocop...
# def get_winning_times(time, distance)
#   a = time**2
#   b = Math.sqrt(a - 4 * -1.0 * -distance)
#   c = 2 * -1.0

#   ((-a + b) / c).ceil..((-a - b) / c).floor
# end

# def multiply_amount_winning_times
#   sum = 1
#   get_all_winning_times(times, distances).each do |times|
#     sum *= times.count
#   end
#   sum
# end

# def amount_winning_times
#   times = get_winning_times(time, distance)
#   times.last - times.first - 1
# end

# # part 1 answer
# puts multiply_amount_winning_times

# # part 2 answer
# puts amount_winning_times

# Day 7
# order = ['A', 'K', 'Q', 'J', 'T', '9', '8', '7', '6', '5', '4', '3', '2'].reverse
# predicates = [:is_five_of_a_kind?, :is_four_of_a_kind?, :is_full_house?, :is_three_of_a_kind?, :is_two_pair?, :is_one_pair?, :is_high_card?].reverse

# def handy_tally(str)
#   str.chars.tally.values.sort
# end

# def is_five_of_a_kind?(str) = handy_tally(str) == [5]
# def is_four_of_a_kind?(str) = handy_tally(str) == [1, 4]
# def is_full_house?(str) = handy_tally(str) == [2, 3]
# def is_three_of_a_kind?(str) = handy_tally(str) == [1, 1, 3]
# def is_two_pair?(str) = handy_tally(str) == [1, 2, 2]
# def is_one_pair?(str) = handy_tally(str) == [1, 1, 1, 2]
# def is_high_card?(str) = handy_tally(str) == [1, 1, 1, 1, 1]

# hands = []
# File.read('day7.txt').lines.each do |line|
#   hand, bid = line.split(' ')
#   rank = [-1]
#   predicates.each_with_index do |pred, index|
#     if send(pred, hand)
#       rank = [[index, rank[0]].max]
#     end
#   end

#   line.chars.each do |c|
#     rank << order.index(c)
#   end

#   # puts "Hand #{hand} Bid #{bid} #{rank}"
#   hands << [rank, bid.to_i]
# end
# hands.sort!
# sum = 0
# hands.each_with_index { |h, idx| sum += (idx + 1) * h[1] }
# puts sum



# order = ['A', 'K', 'Q', 'T', '9', '8', '7', '6', '5', '4', '3', '2', 'J'].reverse
# predicates = [:is_five_of_a_kind?, :is_four_of_a_kind?, :is_full_house?, :is_three_of_a_kind?, :is_two_pair?, :is_one_pair?, :is_high_card?].reverse

# def handy_tally(str)
#   tally = str.chars.tally
#   return [tally.values.sort] unless tally['J']
#   orig = tally.dup
#   j_val = tally.delete('J')
#   ret = [orig.values.sort]
#   tally.each do |k, v|
#     ret << tally.merge(k => v + j_val).values.sort
#   end
#   ret
# end

# def is_five_of_a_kind?(str) = handy_tally(str).any? { |tal| tal == [5] }
# def is_four_of_a_kind?(str) = handy_tally(str).any? { |tal| tal == [1, 4] }
# def is_full_house?(str) = handy_tally(str).any? { |tal| tal == [2, 3] }
# def is_three_of_a_kind?(str) = handy_tally(str).any? { |tal| tal == [1, 1, 3] }
# def is_two_pair?(str) = handy_tally(str).any? { |tal| tal == [1, 2, 2] }
# def is_one_pair?(str) = handy_tally(str).any? { |tal| tal == [1, 1, 1, 2] }
# def is_high_card?(str) = handy_tally(str).any? { |tal| tal == [1, 1, 1, 1, 1] }

# hands = []
# File.read('day7.txt').lines.each do |line|
#   hand, bid = line.split(' ')
#   rank = [-1]
#   predicates.each_with_index do |pred, index|
#     if send(pred, hand)
#       rank = [[index, rank[0]].max]
#     end
#   end

#   line.chars.each do |c|
#     rank << order.index(c)
#   end

#   # puts "Hand #{hand} Bid #{bid} #{rank}"
#   hands << [rank, bid.to_i]
# end
# hands.sort!
# sum = 0
# hands.each_with_index { |h, idx| sum += (idx + 1) * h[1] }
# puts sum

# Day 8

# left_right = files.split("\n")[0]
# coordinates = files.split("\n")[2..-1]
# steps = 0

# coordinates.each do |coordinate|
#     landing_point = coordinate.split(" = ")[0]
#     coordinate_set = coordinate.split(" = ")[1]

#     left_coordinate_set = coordinate_set[1, 3]
#     right_coordinate_set = coordinate_set[6..-2]


#     steps += 1
# end
def for_each_line_with_index(path, no_strip: false)
    idx = 0
    File.readlines(path).each do |line|
        line = line.strip unless no_strip
        yield(line, idx)
        idx += 1
    end
end


# files = File.readlines("day8.txt")
# instructions = []
# instruction_count = 0
# map = {}
# for_each_line_with_index('day8.txt') do |line, idx|
#     if idx.zero?
#         instructions = line.chars
#         instruction_count = instructions.count
#     else
#         next if line == ''

#         key, nodes = line.split(' = ')
#         left, right = nodes.gsub('(', '').gsub(')', '').split(', ')
#         map[key] = { left: left, right: right }
#     end
# end

# next_node = 'AAA'
# step = 0
# while next_node != 'ZZZ'
#     next_node =
#         if instructions[step % instruction_count] == 'L'
#             map[next_node][:left]
#         else
#             map[next_node][:right]
#         end
#     step += 1
# end

# puts step


# instructions = []
# instruction_count = 0
# next_nodes = []
# map = {}
# for_each_line_with_index('day8.txt') do |line, idx|
# if idx.zero?
#     instructions = line.chars
#     instruction_count = instructions.count
# else
#     next if line == ''

#     key, nodes = line.split(' = ')
#     next_nodes << key if key.chars[2] == 'A'
#     left, right = nodes.gsub('(', '').gsub(')', '').split(', ')
#     map[key] = { left: left, right: right }
# end
# end

# steps = []
# next_nodes.each do |next_node|
# step = 0
# while next_node.chars[2] != 'Z'
#     next_node =
#     if instructions[step % instruction_count] == 'L'
#         map[next_node][:left]
#     else
#         map[next_node][:right]
#     end
#     step += 1
# end
# steps << step
# end
# puts steps.reduce(1, :lcm)


# Day 9
lines = File.readlines("day9.txt").map { |x| x.split(" ").map(&:to_i) }

def solve(puzzles)
    puzzles.map do |puzzle|
      rows = [puzzle]
      while !puzzle.all?(&:zero?)
        puzzle = puzzle.each_cons(2).map { |a, b| b - a }
        rows << puzzle
      end
      rows.map(&:last).sum
    end.sum
end

puts solve(lines)
puts solve(lines.map(&:reverse))