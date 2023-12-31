# # # Day 1
# # Read in day1.txt with Ruby
# file = File.open("day1.txt")
# # iterate over contents

# word_digits = {"one" => 1, "two" => 2, "three" => 3, "four" => 4, "five" => 5, "six" => 6, "seven" => 7, "eight" => 8, "nine" => 9}

# output_array = []
# file.each do |line|
#     # for each line, filter out the non-integers, unless the letters appear in sequence as keys in word_digits hash
#     # split the line into an array of characters

#     puts "#{num}"
    
#     # create a new number of the first and last digit in the array
#     # if there's only one digit, create a new number of two of that one digit (e.g. 7 = 77)
#     new_num = nil
#     if num.length == 1
#         new_num = num[0].to_i * 11
#     else
#         new_num = num[0] + num[-1]
#     end
#     new_num = new_num.to_i
#     # add the new number to the output array
#     output_array << new_num
# end

# # sum the output array
# sum = output_array.sum
# puts sum



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
# puts possible_games.sum

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


# # Day 3
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

# # Day 4
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


# # Day 5
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


# Part 2
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
 
#pp seed_ranges
#pp maps
 
# ranges = seed_ranges.map do |seeds|
#   seeds.start...seeds.start+seeds.length
# end.sort_by!(&:first).reverse!
 
# from = :seed
# map_i = 0
# while map_i < maps.length
#   map = maps[map_i]
#   ents = map.entries.sort_by(&:src).reverse!
 
#   puts "#{map.from} ranges #{ranges.inspect}"
 
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
 
# puts "\nfinal ranges #{ranges.reverse.inspect}"
 
# puts ranges[-1].first

# # Day 6
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

# return an array containing ranges of every winning time for each race by zipping
# def get_all_winning_times(times, distances)
#   races = []
#   times.zip(distances).each do |race|
#     races.push(get_winning_times(race[0], race[1]))
#   end
#   races
# end

# get the winning times
# this is the quadratic formula, but i fucked it up beyond recognition to satisfy rubocop...
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

# part 1 answer
# puts multiply_amount_winning_times

# part 2 answer
# puts amount_winning_times

# # Day 7
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

# # Day 8

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


# # Day 9
# lines = File.readlines("day9.txt").map { |x| x.split(" ").map(&:to_i) }

# def solve(puzzles)
#     puzzles.map do |puzzle|
#       rows = [puzzle]
#       while !puzzle.all?(&:zero?)
#         puzzle = puzzle.each_cons(2).map { |a, b| b - a }
#         rows << puzzle
#       end
#       rows.map(&:last).sum
#     end.sum
# end

# puts solve(lines)
# puts solve(lines.map(&:reverse))

# # Day 10
# require 'pp'
 
# input = File.readlines(ARGV[0] || 'day10.txt').map(&:rstrip)
 
# start_row = start_col = 0
# input.each_with_index do |line, row|
#   if (col = line.index('S'))
#     start_row = row
#     start_col = col
#     break
#   end
# end
 
# puts "start at #{start_row}, #{start_col}"
 
# width = input[0].length
# height = input.length
 
# start by searching cardinal directions clockwise beacuse we don't
# know what shape pipe 'S' is
# paths = []
 
# up
# r, c = start_row-1, start_col
# if r >= 0 && r < height && c >= 0 && c < width
#   if '|7F'.index(input[r][c])
#     paths << [r, c]
#   end
# end
# right
# r, c = start_row, start_col+1
# if r >= 0 && r < height && c >= 0 && c < width
#   if '-J7'.index(input[r][c])
#     paths << [r, c]
#   end
# end
# down
# r, c = start_row+1, start_col
# if r >= 0 && r < height && c >= 0 && c < width
#   if '|LJ'.index(input[r][c])
#     paths << [r, c]
#   end
# end
# left
# r, c = start_row, start_col-1
# if r >= 0 && r < height && c >= 0 && c < width
#   if '-LF'.index(input[r][c])
#     paths << [r, c]
#   end
# end
 
# p paths
 
# clean up map
# clean = [nil] * height
# height.times { clean[_1] = '.' * width}
 
# visited = {}
 
# at = paths[0]
# loop do
#   #puts "at #{at.join(', ')}"
#   visited[at] = true
#   r, c = at
#   clean[r][c] = input[r][c]
#   candidates =
#     case input[r][c]
#     when '|' then [[r-1, c], [r+1, c]]
#     when '-' then [[r, c-1], [r, c+1]]
#     when 'L' then [[r-1, c], [r, c+1]]
#     when 'J' then [[r-1, c], [r, c-1]]
#     when '7' then [[r, c-1], [r+1, c]]
#     when 'F' then [[r+1, c], [r, c+1]]
#     when 'S' then break
#     else
#       next
#     end
#   #puts "candidates: #{candidates.inspect}"
#   candidates.each do |pos|
#     r, c = pos
#     if r < 0 || r >= height || c < 0 || c >= width
#       raise "#{at.join(', ')} -> #{r}, #{c} (out of bounds)"
#     end
#     if !visited[pos] # take this path
#       #puts "taking [#{r}][#{c}] = #{input[r][c]}"
#       at = pos
#       break
#     end
#   end
#   #puts "\nat #{at}"
#   #pp clean
# end
 
# puts
# clean.each {puts _1}
 
# now, follow both paths simultaneously until
# counts = [nil] * height
# height.times { counts[_1] = '.' * width}
# counts[start_row][start_col] = '0'
 
# visited = {[start_row, start_col] => true}
# n = 1
# max = 0
# loop do
#   puts "at #{paths[0].join(', ')} | #{paths[1].join(', ')}"
#   nxt = paths.map do |at|
#     visited[at] = true
#     r, c = at
#     counts[r][c] = (n % 10).to_s
#     max = n if n > max
#     candidates =
#       case input[r][c]
#       when '|' then [[r-1, c], [r+1, c]]
#       when '-' then [[r, c-1], [r, c+1]]
#       when 'L' then [[r-1, c], [r, c+1]]
#       when 'J' then [[r-1, c], [r, c-1]]
#       when '7' then [[r, c-1], [r+1, c]]
#       when 'F' then [[r+1, c], [r, c+1]]
#       when 'S' then [] # XXX at end! what do?
#       else []
#       end
#     take = nil
#     candidates.each do |pos|
#       r, c = pos
#       if r < 0 || r >= height || c < 0 || c >= width
#         raise "#{at.join(', ')} -> #{r}, #{c} (out of bounds)"
#       end
#       if !visited[pos] # take this path
#         # puts "taking [#{r}][#{c}] = #{input[r][c]}"
#         take = pos
#         break
#       end
#     end
#     if !take
#     #   puts "no path to take! end?"
#     end
#     # puts "at #{at} -> #{take}"
#     take
#   end
#   print "nxt: "
#   p nxt
 
#   break if nxt.all?{_1 == nil}
#   paths = nxt
#   n += 1
# end
 
# puts
# counts.each {puts _1}
# puts
# puts "max step = #{max}"




# Part 2
# require 'pp'
 
# input = File.readlines(ARGV[0] || 'day10.txt').map(&:rstrip)
 
# start_row = start_col = 0
# input.each_with_index do |line, row|
#   if (col = line.index('S'))
#     start_row = row
#     start_col = col
#     break
#   end
# end
 
# puts "start at #{start_row}, #{start_col}"
 
# $width = input[0].length
# $height = input.length
# puts "#{$width} x #{$height} = #{$width*$height}"
 
# start by searching cardinal directions clockwise beacuse we don't
# know what shape pipe 'S' is
# paths = []
# go = []
 
# up
# r, c = start_row-1, start_col
# if r >= 0 && r < $height && c >= 0 && c < $width
#   if '|7F'.index(input[r][c])
#     paths << [r, c]
#     go << :up
#   end
# end
# right
# r, c = start_row, start_col+1
# if r >= 0 && r < $height && c >= 0 && c < $width
#   if '-J7'.index(input[r][c])
#     paths << [r, c]
#     go << :rt
#   end
# end
# down
# r, c = start_row+1, start_col
# if r >= 0 && r < $height && c >= 0 && c < $width
#   if '|LJ'.index(input[r][c])
#     paths << [r, c]
#     go << :dn
#   end
# end
# left
# r, c = start_row, start_col-1
# if r >= 0 && r < $height && c >= 0 && c < $width
#   if '-LF'.index(input[r][c])
#     paths << [r, c]
#     go << :lt
#   end
# end
 
# print "initial paths: "
# p paths
 
# s_is =
#   if go.include? :up
#     go.include?(:lt) ? 'J' : 'L'
#   elsif go.include? :dn
#     go.include?(:lt) ? '7' : 'F'
#   else
#     nil
#   end
# puts "s is #{s_is}"
 
# clean up map
# clean = [nil] * $height
# $height.times { clean[_1] = '.' * $width}
# clean[start_row][start_col] = 'S'
 
# visited = {[start_row, start_col] => true}
 
# at = paths[0]
# loop do
#   puts "at #{at.join(', ')}"
#   visited[at] = true
#   r, c = at
#   clean[r][c] = input[r][c]
#   candidates =
#     case input[r][c]
#     when '|' then [[r-1, c], [r+1, c]]
#     when '-' then [[r, c-1], [r, c+1]]
#     when 'L' then [[r-1, c], [r, c+1]]
#     when 'J' then [[r-1, c], [r, c-1]]
#     when '7' then [[r, c-1], [r+1, c]]
#     when 'F' then [[r+1, c], [r, c+1]]
#     when 'S' then break
#     else
#       raise "#{r}, #{c} is #{input[r][c]}"
#     end
#   puts "candidates: #{candidates.inspect}"
#   nxt = nil
#   candidates.each do |pos|
#     r, c = pos
#     if r < 0 || r >= $height || c < 0 || c >= $width
#       raise "#{at.join(', ')} -> #{r}, #{c} (out of bounds)"
#     end
#     if !visited[pos] # take this path
#       #puts "taking [#{r}][#{c}] = #{input[r][c]}"
#       nxt = pos
#       break
#     end
#   end
#   break unless nxt
#   at = nxt
#   #puts "\nat #{at}"
#   #pp clean
# end
 
# puts
# clean.each {puts _1}
 
 
# =begin
# flood fill '.'s from outside
# queue = [[0,0]]
# until queue.empty?
#   r, c = queue.pop
#   case clean[r][c]
#   when '.'
#     clean[r][c] = ' '
#     [[-1, 0], [0, 1], [1, 0], [0, -1]].each do |dr, dc|
#       r1 = r + dr; c1 = c + dc
#       if 0 <= r1 && r1 < $height && 0 <= c1 && c1 < $width
#         queue << [r1, c1] if clean[r1][c1] == '.'
#       end
#     end
#   when '|'
#   when '-'
#   when 'L'
#   when 'J'
#   when '7'
#   when 'F'
#   when 'S'
#   end
# end
 
# puts
# clean.each {puts _1}
# =end
 
# =begin
# count remaining '.'s
# ndots = 0
# clean.each do |line|
#   line.each_char {|c| ndots += 1 if c == '.'}
# end
# puts "\n#{ndots} dots remain"
# =end
 
# apply (simplified?) even-odd winding rule
 
# unwound = []
 
# internal = 0
# clean.each do |line|
#   next if line =~ /^\.+$/
#   x = 0
# =begin
#   (0...line.length).each do |col|
#     case line[col]
#     when '|', 'L', 'J', '7', 'F'
#       x += 1
#     when '.'
#       #line[col] = x.even? ? ' ' : '~'
#       line[col] = ' ' if x.even?
#     when 'S'
#       x += 1 if '|LJ7F'.index(s_is)
#     end
# =end
 
#   u = ''
#   line.scan(/F(?:-*J)?|L(?:-*7)?|./) do |m|
#     case m
#     when '|', 'L', 'J', '7', 'F', 'S'
#       x += 1
#       u << m
#     when /F-*J|L-*7/ # these act line one vertical edge
#       x += 1
#       u << m
#     when '.'
#       if x.even?
#         u << ' '
#       else
#         u << '.'
#         internal += 1
#       end
#     else
#       u << m
#     end
#   end
#   unwound << u
# end
 
# puts "\nApply even-odd rule:"
# unwound.each {puts(_1.gsub('.', "\e[94m@\e[0m"))}
 
# puts "\n#{internal} still inside"
 
# puts "\nRemap:"
# symbols = [
#   ['F', "\u250F"],
#   ['J', "\u251B"],
#   ['L', "\u2517"],
#   ['7', "\u2513"],
#   ['|', "\u2503"],
#   ['-', "\u2501"],
# ]
# unwound.each do |line|
#   symbols.each do |a, b|
#     line = line.gsub(a, b)
#   end
#   puts line
# end


# # Day 11 - change the 1000000 to 2 for part 1 answer
# rows = File.readlines('day11.txt').map(&:chomp).map(&:chars)
# inflated_y, inflated_x = [rows, rows.transpose].map { |xs|
#   xs.reduce([]) { |inflated, col|
#     prev = inflated.empty? ? -1 : inflated[-1]
#     inflated << prev + (col.all? { _1 == '.' } ? 1000000 : 1)
#   }
# }
# stars = []
# (0...rows.size).each { |y|
#   (0...rows[0].size).each { |x|
#     stars << [inflated_x[x], inflated_y[y]] if rows[y][x] == '#'
#   }
# }
# result = 0
# (0...stars.size).each { |i|
#   (0...i).each { |j|
#     a, b = stars[i], stars[j]
#     dist = (a[0] - b[0]).abs + (a[1] - b[1]).abs
#     result += dist
#   }
# }
# puts result


# # Day 12
# Part 1
# def solve(chars, seq)
#   unknowns = chars.each_with_index.filter_map { |c, i| i if c == '?' }
#   (0...2 ** unknowns.size).count { |m|
#     unknowns.each_with_index { |i, j| chars[i] = (m & (1 << j)) == 0 ? '.' : '#' }
#     valid?(chars, seq) #.tap { puts chars.join('') if _1}
#   }
# end

# def valid?(chars, seq)
#   chars.chunk { _1 }.filter_map { |c, xs| xs.count if c == '#' } == seq
# end


# puts File.open('day12.txt').map { |line|
#   pattern, seq = line.chomp.split(' ')
#   pattern = pattern.chars
#   seq = seq.split(',').map(&:to_i)
#   solve(pattern, seq) #.tap { puts "#{_1} #{line}"}
# }.sum

# Part 2
# def set_last_part!(chunks, n)
#     chunks[-1] = chunks[-1].dup.tap { _1[-1] = [_1[-1][0], n]; _1.pop if _1[-1][1].zero? }
#     chunks.pop if chunks[-1].empty?
#   end
  
#   def decrement_last_part!(chunks, n = 1) = set_last_part!(chunks, chunks[-1][-1][1] - n)
  
#   def pop_chunk_part(chunks, n = 1)
#     chunks = chunks.dup
#     chunks[-1] = chunks[-1].dup.tap { _1.pop(n) }
#     chunks.pop if chunks[-1].empty?
#     chunks
#   end
  
#   def decrement_last_seq(seq, n)
#     seq.dup.tap { _1[-1] -= n }
#   end
  
#   def pop(arr, n = 1) = arr[0, arr.size - n]
  
#   # .###.
#   def case_single_hash(chunks, seq, depth, hash_len)
#     return 0 unless seq[-1] == hash_len
#     solve(pop(chunks), pop(seq), depth + 1)
#   end
  
#   # .???.
#   def case_single_q(chunks, seq, depth, q_len)
#     if_all_dot = solve(pop(chunks), seq, depth + 1)
#     if_some_hash =
#       if seq[-1] > q_len
#         0
#       else
#         # Set prefix to '#':
#         hash_prefix = solve(pop(chunks), pop(seq), depth + 1)
#         # Any '#' infix of length `seq[-1]` preceded by '.', continue with the remaining '?' prefix:
#         hash_infix = (0..(q_len - seq[-1] - 1)).lazy.map { |rem|
#           solve(chunks.dup.tap { set_last_part!(_1, rem) }, pop(seq), depth + 1)
#         }.sum
#         hash_prefix + hash_infix
#       end
#     if_all_dot + if_some_hash
#   end
  
#   # *?#.
#   def case_last_hash(chunks, seq, depth, hash_len)
#     if hash_len > seq[-1]
#       0
#     elsif hash_len == seq[-1]
#       solve(pop_chunk_part(chunks).tap { decrement_last_part!(_1) }, pop(seq), depth + 1)
#     else # hash_len < seq[-1]
#       q_len = chunks[-1][-2][1]
#       if q_len + hash_len == seq[-1]
#         if chunks[-1].size == 2
#           solve(pop(chunks), pop(seq), depth + 1)
#         else
#           0
#         end
#       elsif q_len + hash_len < seq[-1]
#         if chunks[-1].size == 2
#           0
#         else
#           solve(pop_chunk_part(chunks, 2), decrement_last_seq(seq, q_len + hash_len), depth + 1)
#         end
#       else # q_len + hash_len > seq[-1]
#         solve(pop_chunk_part(chunks).tap { decrement_last_part!(_1, seq[-1] - hash_len + 1) }, pop(seq), depth + 1)
#       end
#     end
#   end
  
#   # *#?.
#   def case_last_q(chunks, seq, depth, q_len)
#     result = 0
#     chunks_without_q = pop_chunk_part(chunks)
#     # We can always choose a '#' prefix <= seq[-1] and continue
#     result += (0..[q_len, seq[-1]].min).lazy.map { |hash_prefix_len|
#       solve(chunks_without_q, decrement_last_seq(seq, hash_prefix_len), depth + 1)
#     }.sum
  
#     if q_len > seq[-1]
#       # Any '#' infix of length `seq[-1]` preceded by '.', continue with the remaining '?' prefix:
#       result += (0..(q_len - seq[-1] - 1)).lazy.map { |rem|
#         solve(chunks.dup.tap { set_last_part!(_1, rem) }, pop(seq), depth + 1)
#       }.sum
#     end
#     result
#   end
  
#   def do_solve(chunks, seq, depth)
#     if chunks.empty?
#       return 1 if seq.empty?
#       return 0
#     end
#     if seq.empty?
#       return 1 if chunks.all? { _1 in [['?', _]] }
#       return 0
#     end
#     case chunks[-1]
#     in [['#', hash_len]] then case_single_hash(chunks, seq, depth, hash_len)
#     in [['?', q_len]] then case_single_q(chunks, seq, depth, q_len)
#     in [*, ['#', hash_len]] then case_last_hash(chunks, seq, depth, hash_len)
#     in [*, ['?', q_len]] then case_last_q(chunks, seq, depth, q_len)
#     end
#   end
  
#   CACHE = {}
#   def solve(chunks, seq, depth = 0)
#     CACHE[[chunks, seq]] ||= begin
#       log = false
#       #log = true
#       puts "#{'  ' * depth}solve #{chunks.inspect} #{seq.inspect}" if log
#       do_solve(chunks, seq, depth).tap { puts "#{'  ' * depth}=> #{_1}" if log }
#     end
#   end
  
#   n = 5
#   puts File.open("day12.txt").map { |line|
#     pattern, seq = line.chomp.split(' ')
#     pattern = ([pattern] * n).join('?').chars
#     seq = seq.split(',').map(&:to_i)
#     seq *= n
  
#     # A list of [char, len]
#     chunks = pattern.chunk { _1 }.map { [_1, _2.count] }
  
#     # Sequences of /[#?]+/
#     chunks = chunks.chunk { _1[0] != '.' }.filter { _1[0] }.map { _1[1] }
#     solve(chunks, seq) #.tap { puts "#{_1} #{line}"}
#   }.sum


# # Day 13
# # Day 13
# INPUT = "day13.txt"
 
# def parse_grids
#   File.foreach(INPUT).chunk do |line|
#     /\A\s*\z/ !~ line || nil
#   end.map do |_, lines|
#     lines.map(&:strip).map { |line| line.chars }
#   end
# end
 
# def row_diff(row1, row2)
#   row1.zip(row2).count { |e1, e2| e1 != e2 }
# end
 
# def find_reflection_row(grid, required_smudges)
#   max_mid = -1
#   (0...grid.size - 1).each do |middle|
#     up = middle
#     down = up + 1
 
#     is_reflection = true
#     smudges = 0
#     while up >= 0 && down <= grid.size - 1
#       diff = row_diff(grid[up], grid[down])
#       smudges += diff
#       if smudges > required_smudges
#         is_reflection = false
#         break
#       end
#       up -= 1
#       down += 1
#     end
 
#     max_mid = middle if smudges == required_smudges && is_reflection && (up <= 0 || down >= grid.size - 1)
#   end
#   max_mid + 1
# end
 
# def find_reflection_column(grid, required_smudges)
#   find_reflection_row(grid.transpose, required_smudges)
# end
 
# def score(grid, required_smudges)
#   ref_row = find_reflection_row(grid, required_smudges)
#   ref_column = find_reflection_column(grid, required_smudges)
#   100 * ref_row + ref_column
# end
 
# grids = parse_grids
# ans1 = grids.map { |grid| score(grid, 0) }.sum
# ans2 = grids.map { |grid| score(grid, 1) }.sum
 
# puts "Part 1 #{ans1}"
# puts "Part 2 #{ans2}"

# # Day 14
# def tilt_north(data)
#     data = data.map(&:dup)
#     (0...data.size).each { |y|
#       (0...data[0].size).each { |x|
#         next unless data[y][x] == 'O'
#         new_y = (0...y).reverse_each.lazy.
#           take_while { data[_1][x] == '.' }.reduce { _2 }
#         if new_y
#           data[new_y][x] = 'O'
#           data[y][x] = '.'
#         end
#       }
#     }
#     data
#   end
  
#   def north_load(data)
#     (0...data.size).lazy.filter_map { |y|
#       (0...data[0].size).lazy.filter_map { |x|
#         data.size - y if data[y][x] == 'O'
#       }.sum
#     }.sum
#   end

# data = File.open("day14.txt").readlines(chomp: true)
# puts north_load(tilt_north(data))

# def transpose(data) = data.map(&:chars).transpose.map(&:join)
# def reverse(data) = data.reverse

# def tilt_south(data) = reverse tilt_north reverse data
# def tilt_west(data) = transpose tilt_north transpose data
# def tilt_east(data) = transpose reverse tilt_north reverse transpose data
# def cycle(data) = tilt_east tilt_south tilt_west tilt_north data

# def cycles(data, n)
#   seq = [data]
#   cycle_begin = 0
#   loop do
#     data = cycle(data)
#     idx = seq.index(data)
#     if !idx.nil?
#       cycle_begin = idx
#       break
#     end
#     seq << data
#   end
#   return seq[n] if n < cycle_begin
#   seq[cycle_begin + ((n - cycle_begin) % (seq.size - cycle_begin))]
# end

# data = File.open("day14.txt").readlines(chomp: true)
# data = cycles(data, 1000000000)
# puts north_load(data)

# Day 15
# input = File.read("day15.txt").tr("\r\n", '').split(',')
# hash = ->(l) { l.bytes.reduce(0) { (_1 + _2) * 17 % 256 } }

# boxes = {}
# input.map do |l|
#     lbl, op = l.split(/[=-]/)
#     box = boxes[1 + hash[lbl]] ||= []
#     i = box.index { _1[0] == lbl } || box.size
#     op ? box[i] = [lbl, op.to_i] : box.delete_at(i)
# end

# puts "Part 1: #{input.sum(&hash)}"
# puts "Part 2: #{boxes.sum { |(i, b)| i * b.map.with_index.sum { |l, j| -~j * l[1] } }}"

# Day 16
class FileReader
  class << self
    def read_file(path)
      File.read(path.strip)
    end

    def for_each_line(path, no_strip: false)
      File.readlines(path).each do |line|
        line = line.strip unless no_strip
        yield(line)
      end
    end

    def for_each_line_with_index(path, no_strip: false)
      idx = 0
      File.readlines(path).each do |line|
        line = line.strip unless no_strip
        yield(line, idx)
        idx += 1
      end
    end
  end
end
# def run(path, _)
#   directions = {
#     up: lambda do |map, x, y|
#           (y - 1).downto(0).each do |id|
#             break if map["#{x}:#{id}"].nil?
#             return [x, id] if map["#{x}:#{id}"][:content] != '.'

#             map["#{x}:#{id}"][:visited] += 1
#           end
#           [x, 0]
#         end,
#     down: lambda do |map, x, y|
#             ((y + 1)..120).each do |id|
#               break if map["#{x}:#{id}"].nil?
#               return [x, id] if map["#{x}:#{id}"][:content] != '.'

#               map["#{x}:#{id}"][:visited] += 1
#             end
#             [x, 120]
#           end,
#     left: lambda do |map, x, y|
#             (x - 1).downto(0).each do |id|
#               break if map["#{id}:#{y}"].nil?
#               return [id, y] if map["#{id}:#{y}"][:content] != '.'

#               map["#{id}:#{y}"][:visited] += 1
#             end
#             [0, y]
#           end,
#     right: lambda do |map, x, y|
#              ((x + 1)..120).each do |id|
#                break if map["#{id}:#{y}"].nil?
#                return [id, y] if map["#{id}:#{y}"][:content] != '.'

#                map["#{id}:#{y}"][:visited] += 1
#              end
#              [120, y]
#            end
#   }
#   reflections = {
#     '\\' => { right: [:down], down: [:right], left: [:up], up: [:left] },
#     '/' => { right: [:up], down: [:left], left: [:down], up: [:right] },
#     '|' => { left: %i[up down], up: [], right: %i[up down], down: [] },
#     '-' => { left: [], up: %i[right left], right: [], down: %i[right left] }
#   }
#   map = {}
#   x_max = 0
#   y_max = 0
#   FileReader.for_each_line_with_index(path) do |line, y|
#     line.chars.each_with_index do |char, x|
#       map["#{x}:#{y}"] = { content: char, visited: 0 }
#       x_max = x
#     end
#     y_max = y
#   end

#   counts = []

#   (0..x_max).each do |x|
#     new_map = Marshal.load(Marshal.dump(map))
#     walk(new_map, directions, reflections, x, 0, :down, {})
#     counts << new_map.values.select { |v| v[:visited].positive? }.count
#     new_map = Marshal.load(Marshal.dump(map))
#     walk(new_map, directions, reflections, x, y_max, :up, {})
#     counts << new_map.values.select { |v| v[:visited].positive? }.count
#   end

#   (0..y_max).each do |y|
#     new_map = Marshal.load(Marshal.dump(map))
#     walk(new_map, directions, reflections, 0, y, :right, {})
#     counts << new_map.values.select { |v| v[:visited].positive? }.count
#     new_map = Marshal.load(Marshal.dump(map))
#     walk(new_map, directions, reflections, x_max, y, :left, {})
#     counts << new_map.values.select { |v| v[:visited].positive? }.count
#   end

#   counts.max
# end
# def walk(map, directions, reflections, x, y, dir, visited)
#   return unless visited["#{x}:#{y}:#{dir}"].nil?

#   visited["#{x}:#{y}:#{dir}"] = 1
#   coords = "#{x}:#{y}"
#   return if map[coords].nil?

#   map_content = map[coords][:content]
#   map[coords][:visited] += 1

#   if map_content == '.' || reflections[map_content][dir].count.zero?
#     x_new, y_new = directions[dir].(map, x, y)
#     walk(map, directions, reflections, x_new, y_new, dir, visited)
#   else
#     dir1, dir2 = reflections[map_content][dir]
#     unless dir1.nil?
#       x_new, y_new = directions[dir1].(map, x, y)
#       walk(map, directions, reflections, x_new, y_new, dir1, visited)
#     end
#     unless dir2.nil?
#       x_new, y_new = directions[dir2].(map, x, y)
#       walk(map, directions, reflections, x_new, y_new, dir2, visited)
#     end
#   end
# end
# puts run('day16.txt', nil)



# Day 17
# require_relative 'skim'
# require_relative 'search'

# class SearchNode < Search::Node
#   attr_accessor :map, :x, :y, :from_dir, :from_count
#   def initialize(map, x, y, from_dir = nil, from_count = 0)
#     self.map = map
#     self.x = x
#     self.y = y
#     self.from_dir = from_dir
#     self.from_count = from_count
#   end

#   def fuzzy_equal?(other)
#     x == other.x && y == other.y
#   end

#   def est_cost(other)
#     (other.x - x).abs + (other.y - y).abs
#   end

#   def backtrack?(from_dir, to_dir)
#     case from_dir
#     when :l then to_dir == :r
#     when :u then to_dir == :d
#     when :r then to_dir == :l
#     when :d then to_dir == :u
#     end
#   end

#   def do_edge(dir, x1, y1)
#     return if backtrack?(from_dir, dir)
#     unless from_dir.nil?
#       if from_dir == dir
#         return if from_count >= 10
#       else
#         return if from_count < 4
#       end
#     end

#     yield [map[x1, y1].to_i, SearchNode.new(map, x1, y1, dir, from_dir == dir ? from_count + 1 : 1)]
#   end

#   def enum_edges(&)
#     do_edge(:l, x - 1, y, &) if x > 0
#     do_edge(:u, x, y - 1, &) if y > 0
#     do_edge(:r, x + 1, y, &) if x < map.width - 1
#     do_edge(:d, x, y + 1, &) if y < map.height - 1
#   end

#   def hash
#     [x, y, from_dir, from_count].join('/').hash
#   end
# end

# Day 18
def self.run(path, input)
  vis = false
  x = 0
  y = 0
  x_max = 0
  y_max = 0
  x_min = 0
  y_min = 0
  map = {}
  min_max = {}
  map["#{x}:#{y}"] = 'F'
  grid_size = (input == 'sample' ? 10 : 400)
  grid = Array.new(grid_size) { Array.new(grid_size) { '.' } }
  grid[input == 'sample' ? 0 : 78][0] = 'F'

  corner_lookup = {
    'DL' => 'J',
    'LD' => 'F',
    'RU' => 'J',
    'UR' => 'F',
    'DR' => 'l',
    'RD' => '7',
    'LU' => 'l',
    'UL' => '7'
  }

  last_dir = 'R'
  FileReader.for_each_line(path) do |line|
    dir, dist, = line.gsub('(', '').gsub(')', '').split
    dist.to_i.times do
      unless corner_lookup["#{last_dir}#{dir}"].nil?
        grid[y + (input == 'sample' ? 0 : 78)][x] = corner_lookup["#{last_dir}#{dir}"] if vis
        map["#{x}:#{y}"] = corner_lookup["#{last_dir}#{dir}"]
      end

      y -= 1 if dir == 'U'
      y += 1 if dir == 'D'
      x -= 1 if dir == 'L'
      x += 1 if dir == 'R'

      x_max = x if x > x_max
      y_max = y if y > y_max
      x_min = x if x < x_min
      y_min = y if y < y_min

      if vis
        grid[y + (input == 'sample' ? 0 : 78)][x] = dir unless x.zero? && y.zero?
      end
      map["#{x}:#{y}"] = dir unless x.zero? && y.zero?

      if min_max[y].nil?
        min_max[y] = { min: x, max: x }
      else
        min_max[y][:max] = x if x > min_max[y][:max]
        min_max[y][:min] = x if x < min_max[y][:min]
      end

      last_dir = dir
    end
  end

  inside = 0
  (y_min..y_max).each do |y|
    count = 0
    ((min_max[y][:min] - 1)..(min_max[y][:max] + 1)).each do |x|
      count += 1 if !map["#{x}:#{y}"].nil? && %w[U D J l].include?(map["#{x}:#{y}"])
      next unless map["#{x}:#{y}"].nil?

      if count.odd?
        inside += 1
        grid[y + (input == 'sample' ? 0 : 78)][x] = 'I' if vis
      end
    end
  end

  Visualisation.print_grid(grid, centre_x: (input == 'sample' ? 5 : 200), centre_y: (input == 'sample' ? 5 : 200), x_dim: (input == 'sample' ? 10 : 400), y_dim: (input == 'sample' ? 10 : 400), sleep: 0.01, spacer: '', empty_char: '.', no_clear: true, character_colours: { 'I' => :red }) if vis

  inside + map.count
end
puts run("day18.txt", nil)

def self.run(path, _)
  points = [[0, 0]]
  boundry_points = 0
  FileReader.for_each_line(path) do |line|
    _, val = line.gsub('(', '').gsub(')', '').split('#')

    val = val.chars
    dir = val.pop
    dist = val.join.to_i(16)

    boundry_points += dist
    x, y = points.last

    points << [x + dist, y] if dir == '0'
    points << [x, y + dist] if dir == '1'
    points << [x - dist, y] if dir == '2'
    points << [x, y - dist] if dir == '3'
  end

  sum = 0
  points.each_with_index do |(x1, y1), id|
    break if id == points.count - 2
    next if points[id + 1].nil?

    x2, y2 = points[id + 1]
    sum += (y1 + y2) * (x1 - x2)
  end

  (sum / 2) - (boundry_points / 2) + 1 + boundry_points
end
puts run("day18.txt", nil)