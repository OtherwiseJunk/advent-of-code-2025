def part_1(rotation_instructions, current_dial_value)
  final_state = rotation_instructions.each_with_object({ value: current_dial_value, zero_count: 0 }) do |instruction, state|
    direction, clicks = extract_direction_and_clicks(instruction)

    multiplier = direction == 'R' ? 1 : -1
    state[:value] = (state[:value] + (clicks * multiplier)) % 100

    state[:zero_count] += 1 if state[:value].zero?
  end

  final_state[:zero_count]
end

def part_2(rotation_instructions, current_dial_value)
  final_state = rotation_instructions.each_with_object({ value: current_dial_value, zero_count: 0 }) do |instruction, state|
    direction, clicks = extract_direction_and_clicks(instruction)
    multiplier = direction == 'R' ? 1 : -1

    clicks.times do
      state[:value] = (state[:value] + multiplier) % 100
      state[:zero_count] += 1 if state[:value].zero?
    end
  end
  final_state[:zero_count]
end

def extract_direction_and_clicks(instruction)
  direction = instruction[0]
  clicks = instruction[1..-1].to_i
  [direction, clicks]
end

raw_test_data = File.read("inputs/1a.txt")
rotation_instructions = raw_test_data.split("\n").map(&:strip)

current_dial_value = 50
part_one_password = part_1(rotation_instructions, current_dial_value)
part_two_password = part_2(rotation_instructions, current_dial_value)

puts "Part 1 Password: #{part_one_password}"
puts "Part 2 Password: #{part_two_password}"
