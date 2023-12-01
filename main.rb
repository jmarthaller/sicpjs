# Day 1
# Read in day1.txt with Ruby
file = File.open("day1.txt")
# iterate over contents
output_array = []
file.each do |line|
    # for each line, filter out the non-integers
    num = line.split("").filter { |char| char.to_i.to_s == char }
    
    # create a new number of the first and last digit in the array
    # if there's only one digit, create a new number of two of that one digit (e.g. 7 = 77)
    new_num = nil
    if num.length == 1
        new_num = num[0].to_i * 11
    else
        new_num = num[0] + num[-1]
    end
    new_num = new_num.to_i
    # add the new number to the output array
    output_array << new_num
end

# sum the output array
sum = output_array.sum
puts sum
