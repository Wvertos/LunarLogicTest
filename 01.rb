def maxim(arr, n, b)
  n -= 1
  diff = [0, 0, 0]
  (b..2).each do |i|
    if arr[i] >= 0
      s = arr[i].to_s
      k = 0
      (0..s.length-1).each do |j|
        if s[j] != "9"
          sj = s[j].to_i
          k1 = 9 - sj
          if k1 > 3 - k
            k1 = 3 - k
          end
          diff[i] += k1 * 10**(s.length-j-1)
          k += k1
          break if k == 3
        end
      end
    end
  end
  maxdiff = diff.max
  if maxdiff == 0
    return arr
  end
  marr = []
  (b..2).each do |i|
    if diff[i] == maxdiff
      barr = []
      barr += arr
      barr[i] += diff[i]
      if n != 0
        barr = maxim(barr, n, i)
      end
      marr.push(barr)
    end
  end
  return marr
end



$, = ", "
$\ = "\n"
puts "Enter whole numbers separated by spaces:"
arr = gets.split.map(&:to_i)
c = 6 



(0..2).each do |i|
  b = arr[i].abs % 3
  if b != 0
    b = 3 - b
    c -= b
    if arr[i] < 0
      a1 = arr[i].abs
      k = 0
      while b > 0
        a2 = 9 - a1 % 10
        if a2 != 0
          if a2 <= b
            a3 = a2
          else
            a3 = b
          end
          arr[i] -= a3 * 10**k
          b -= a3
        end
        a1 = a1.div(10)
        k += 1
      end
    end
    if arr[i] > 0
      s = arr[i].to_s
      (0..s.length-1).each do |j|
        if s[j] != "9"
          sj = s[j].to_i
          k = 9 - sj
          if k <= b
            a2 = k
          else
            a2 = b
          end
          s[j] = (a2 + sj).to_s
          b -= a2
        end
        break if b == 0
      end
      arr[i] = s.to_i
    end
  end
end


if c >= 3
  arr1 = maxim(arr, c.div(3), 0)
end
if arr1 and arr != arr1
  print *arr1.flatten(c.div(3)-1)
else
  print arr
end