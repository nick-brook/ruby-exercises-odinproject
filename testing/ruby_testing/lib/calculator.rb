class Calculator
  def add(*args)
    args.sum
  end

  def multiply(*args)
    args.reduce {|product, x | product * x }
  end
end