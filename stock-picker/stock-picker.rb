def stock_picker(price_array)
  i = 0
  results = [0, 0, 0]

  ## loop through each day
  while i < (price_array.length - 1)

    #  pice to buy for that day
    buy_price = price_array[i]

    # slice array with future prices and get max for bext selling price
    sell_price = price_array.slice(i + 1, price_array.length - 1).max
    sell_day = price_array.find_index(sell_price)

    #  if this is the highest profit store
    if (sell_price - buy_price) > results[2]
      results = [i, sell_day, (sell_price - buy_price)]
    end
    i += 1

  end

  "The best time to buy is day #{results[0]}, selling on day #{results[1]}. This makes a profit of #{results[2]}"
end

p stock_picker([5, 1, 17, 3, 6, 9, 8, 15, 8, 6, 1, 10])
