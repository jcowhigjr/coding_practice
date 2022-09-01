module Test
  # param [Integer] items
  # param [Integer] available_large_packages
  # param [Integer] available_small_packages
  #

  # return [Integer] The minimum number of packages needed to hold a given number of items
  def self.minimal_number_of_packages(items, available_large_packages, available_small_packages)
    return nil unless items.is_a?(Integer) && available_large_packages.is_a?(Integer) && available_small_packages.is_a?(Integer)
    return 0 if items == 0

    items_remaining = items
    total_packages = 0

    while items_remaining >= 1
      if available_large_packages >= 1 && items_remaining >= 5
        items_remaining -= 5
        total_packages += 1
        available_large_packages -= 1
      elsif available_small_packages >= 1
        items_remaining -= 1
        total_packages += 1
        available_small_packages -= 1
      else # leftover items
        # puts "items remaining: #{items_remaining}"
        # puts "available large packages: #{available_large_packages}"
        # puts "available small packages: #{available_small_packages}"
        # puts "total packages: #{total_packages}"
        return -1
      end
    end
    total_packages == 0 ? -1 : total_packages
  end
end
