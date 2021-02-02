def bubble_sort(sort_array)
  # set swapcounter to non zero value
  swap_count = 1

  ## loop swap counter != 0
  while swap_count != 0

    # set swap counter to 0
    swap_count = 0

    # loop through each element in array
    sort_array.each_with_index do |item, index|
      if sort_array[index + 1]
        # check adjacent elements are in order swap if not
        if item > sort_array[index + 1]
          sort_array[index] = sort_array[index + 1]
          sort_array[index + 1] = item
          swap_count += 1
        end
      end
    end
  end
  sort_array
end

p bubble_sort([4, 3, 78, 20, 0, 2])
