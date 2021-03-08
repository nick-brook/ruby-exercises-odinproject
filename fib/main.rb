def fib(num)
  arr = [0, 1]
  if num <= 2
    arr.slice(0, num)
  else
    0.upto(num - 3).each { |i| arr.push(arr[i] + arr[i + 1]) }
  end
end

def fib_rec(first_num, next_num, num)
  num.zero? ? first_num : fib_rec(next_num, first_num + next_num, num - 1)
end

def fib_r(num)
  fib_rec(0, 1, num)
end

# merge sort
def merge_sort(arr)
  # base case when arr length 1 or 0
  return arr if arr.length < 2

  # recursively sort the left half of the array
  arr_a = merge_sort(arr.slice!(0, arr.length / 2))
  # recursively sort the right half of the array
  arr_b = merge_sort(arr)
  # merge together the two smaller arrays
  merged_arr = []
  # smallest element is always at start of one of the arary
  while arr_a.length.positive? && arr_b.length.positive?
    arr_a[0] < arr_b[0] ? merged_arr.push(arr_a.shift) : merged_arr.push(arr_b.shift)
  end
  arr_a.length.positive? ? merged_arr + arr_a : merged_arr + arr_b
end

merge_array = [2, -8, 3, 5, 78, 1, 34, 6]

p merge_sort(merge_array)
# p(0..100).map { |item| fib_r(item) }
# num = 1
# p fib_r(num)
# p fib(num)
