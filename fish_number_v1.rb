
def ack_like(m, n, f)
  if m == 0
    f.call(n)
  elsif n == 0
    ack_like(m - 1, 1, f)
  else
    ack_like(m - 1, ack_like(m, n - 1, f), f)
  end
end

def func_s_conversion(f)
  lambda do |x|
    ack_like(x, x, f)
  end
end

def s_conversion(pair)
  num = pair[0]
  func = pair[1]

  new_func = func_s_conversion(func)
  num = new_func.call(num)
  [num, new_func]
end

pair = s_conversion([1, lambda {|x| x + 1}])
pair = s_conversion(pair)

p pair[0]

