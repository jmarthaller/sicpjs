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
limits = {
    'blue' => 14,
    'red' => 12,
    'green' => 13
}
possible_games = []
impossible_games = []
file = File.open("day2.txt")

file.each do |line|
    game_id, subsets = line.split(': ')
    game_id = game_id.gsub('Game ', '').to_i
    possible = true
    subsets.split(';').each do |subset|
    next unless possible

    subset.split(',').each do |colour_pair|
        next unless possible

        num, colour = colour_pair.split
        if num.to_i > limits[colour]
        possible = false
        next
        end
    end
    end
    if possible
    possible_games << game_id
    else
    impossible_games << game_id
    end
end
# puts possible_games.sum

powers = {}
file = File.open("day2.txt")

file.each do |line|
game_id, subsets = line.split(': ')
game_id = game_id.gsub('Game ', '').to_i
values = {}
subsets.split(';').each do |subset|
    subset.split(',').each do |colour_pair|
    num, colour = colour_pair.split
    values[colour] = num.to_i if values[colour].nil? || num.to_i > values[colour]
    end
end
powers[game_id] = values.values.inject(:*)
end
puts powers.values.sum
