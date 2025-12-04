def part_1(battery_banks)
  final_state = battery_banks.each_with_object({ joltage: 0 }) do |bank, state|
    batteries = bank.digits.reverse

    largest_idx = -1
    other_max = -1
    largest = batteries.max
    largest_idx = batteries.index(largest)

    batteries.each_with_index { |d, i| other_max = d if i != largest_idx && d > other_max }

    if largest == batteries[-1]
      state[:joltage] += (other_max * 10) + largest
    else
      right_max = batteries[(largest_idx + 1)..].max || 0
      state[:joltage] += (largest * 10) + right_max
    end
  end

  final_state[:joltage]
end

def part_2(battery_banks, n = 12)
  final_state = battery_banks.each_with_object({ joltage: 0 }) do |bank, state|
    batteries = bank.digits.reverse
    d_len = batteries.length
    next if d_len < n

    result_batteries = []
    current_pos = 0

    (n.downto(1)).each do |remaining_picks|
      search_window = batteries[current_pos..(d_len - remaining_picks)]

      best_digit = search_window.max
      result_batteries << best_digit

      current_pos += search_window.index(best_digit) + 1
    end

    state[:joltage] += result_batteries.join.to_i
  end
  final_state[:joltage]
end

raw_text_data = File.read("inputs/3.txt")
battery_banks = raw_text_data.split("\n").map { |line| line.to_i }

puts" Part 1 Result: #{part_1(battery_banks)}"
puts" Part 2 Result: #{part_2(battery_banks)}"
