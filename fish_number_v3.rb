
def s_map(n, f)
  if n == 1
    lambda do |x|
      val = x
      x.times do
        val = f.call(val)
      end
      val
    end
  else
    lambda do |x|
      g = f
      x.times do
        g = s_map(n - 1, g)
      end
      g.call(x)
    end
  end
end

def ss_map(n, f)
  if n == 1
    lambda do |x|
      g = s_map(x, f)
      g.call(x)
    end
  else
    lambda do |x|
      g = f
      x.times do
        g = ss_map(n - 1, g)
      end
      g.call(x)
    end
  end
end

f = lambda{|x| x + 1}
63.times do
  f = ss_map(2, f)
end
f3_function = f

val = 3
63.times do
  val = f3_function.call(val)
end

puts "#{val}"

