module Test
  def self.move_zeros(nums = [])
    # slow pointer

    # fast pointer
    # fast pointer is the first non-zero number
    fast_pointer = 0
    nums.each_with_index do |num, index|
      next if num.zero?

      nums[index], nums[fast_pointer] = nums[fast_pointer], nums[index] if fast_pointer != index
      fast_pointer += 1
    end
    nums
  end

  def self.remove_element(nums, val)
    # slow pointer

    # fast pointer
    # fast pointer is the first non-zero number
    fast_pointer = 0
    nums.each_with_index do |num, index|
      nums[index] = nil if num == val
      next if num == val

      nums[index], nums[fast_pointer] = nums[fast_pointer], nums[index] if fast_pointer != index
      fast_pointer += 1
    end
    "#{nums.compact.length}, nums = #{nums.compact}"
  end
end
