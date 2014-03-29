
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
  (m, f) = pair

  g = s_func_conversion(f)

  [g.call(m), g]
end

def ss_s2_conversion(s)
  lambda do |pair|
    (m, f) = pair
    f.call(m).times do
      pair = s.call(pair)
    end
    pair
  end
end

def ss_s2_power_conversion(s)
  lambda do |pair|
    (m, f) = pair
    m.times do
      pair = ss_s2_conversion.call(pair)
    end
    pair
  end
end

def ss_conversion(trio)
  (m, f, s) = trio

  s2 = ss_s2_conversion(s)
  (n, p) = s2.call([m, f])
  s2_power = ss_s2_power_conversion(s)
  (q_x, g) = s2_power.call([m, f])

  [n, g, s2_power]
end

trio = [3, lambda {|x| x + 1}, lambda{|pair| s_conversion(pair)}]

63.times do
  trio = ss_conversion(trio)
end

puts "#{trio[0]}\n"

