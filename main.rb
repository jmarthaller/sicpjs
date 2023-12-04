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
file = File.open("day4.txt")
points = 0

file.each do |line|
    point_multiplier = false
    inner_points = 0

    winning_numbers, owned_numbers = line.split("|").map { |side| side.split.map(&:to_i) }
    winning_numbers.shift(2)

    owned_numbers.each do |num|
        if winning_numbers.include?(num) && !point_multiplier
            inner_points += 1
            point_multiplier = true
        elsif winning_numbers.include?(num) && point_multiplier
            inner_points *= 2
        end
    end

    points += inner_points
    inner_points = 0
    point_multiplier = false
end

puts points