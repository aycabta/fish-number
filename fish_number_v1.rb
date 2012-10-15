
def ack_like(m, n, f)
  if m == 0
    f.call(n)
  elsif n == 0
    ack_like(m - 1, 1, f)
  else
    ack_like(m - 1, ack_like(m, n - 1, f), f)
  end
end

def s_func_conversion(f)
  lambda do |x|
    ack_like(x, x, f)
  end
end

def s_conversion(pair)
  m = pair[0]
  f = pair[1]

  g = s_func_conversion(f)
  n = g.call(m)

  [n, g]
end

def ss_s2_conversion(s)
  lambda do |pair|
    pair[1].call(pair[0]).times do
      pair = s.call(pair)
    end
    pair
  end
end

def ss_conversion(trio)
  m = trio[0]
  f = trio[1]
  s = trio[2]

  s2 = ss_s2_conversion(s)
  (n, g) = s2.call([m, f])

  [n, g, s2]
end

trio = [3, lambda {|x| x + 1}, lambda{|pair| s_conversion(pair)}]

63.times do
  trio = ss_conversion(trio)
end

puts "#{trio[0]}\n"

