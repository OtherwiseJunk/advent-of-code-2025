def part_1(product_id_ranges)
  final_state = product_id_ranges.each_with_object({ invalid_sum: 0 }) do |range_str, state|
    lower_bound, upper_bound = range_str.split("-").map(&:to_i)

    (lower_bound..upper_bound).each do |product_id|
      next if product_id < 10

      num_digits = Math.log10(product_id).to_i + 1
      next if num_digits.odd?

      divisor = 10**(num_digits / 2)
      first_half = product_id / divisor
      second_half = product_id % divisor

      state[:invalid_sum] += product_id if first_half == second_half
    end
  end

  final_state[:invalid_sum]
end

def part_2(product_id_ranges)
  final_state = product_id_ranges.each_with_object({ invalid_sum: 0 }) do |range_str, state|
    lower_bound, upper_bound = range_str.split("-").map(&:to_i)

    (lower_bound..upper_bound).each do |product_id|
      s = product_id.to_s
      len = s.length
      next if len < 2

      (1..len / 2).each do |p_len|
        next unless len % p_len == 0

        pattern = s[0, p_len]
        repetitions = len / p_len

        if pattern * repetitions == s
          state[:invalid_sum] += product_id
          break
        end
      end
    end
  end
  final_state[:invalid_sum]
end

raw_test_data = File.read("inputs/2.txt")
product_id_ranges = raw_test_data.split(",").map(&:strip)

sum_of_invalid_product_ids = part_1(product_id_ranges)
sum_of_part_2_ids = part_2(product_id_ranges)

puts "Sum of Invalid Product IDs: #{sum_of_invalid_product_ids}"
puts "Part 2 Results: #{sum_of_part_2_ids}"
