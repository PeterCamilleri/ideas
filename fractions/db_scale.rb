#
# Compute a rational approximation of a db scale.
#
# From https://www.johndcook.com/blog/2010/10/20/best-rational-approximation/
#

def farey(value, limit)
  a,b = 0,1
  c,d = 1,1

  while (b <= limit) && (d <= limit)
    mediant = Float(a+c)/Float(b+d)

    if value > mediant
      a,b = a+c, b+d
    else
      c,d = a+c, b+d
    end

  end

  (b <= limit) ? [a,b] : [c,d]
end

result = (0...64).map do |i|
  log_gain = -i/20.0
  lin_gain = 10 ** log_gain
  num, den = farey(lin_gain, 256 + 64*i)
  actual = Float(num)/Float(den)
  error = (actual - lin_gain) / lin_gain

  [i, log_gain, lin_gain, num, den, error].join(' ')

end

puts result
