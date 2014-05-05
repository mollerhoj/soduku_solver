# Given a number, calculate what other numbers are affected with: affected(x)

def affected_rows(x)
  res = []
  row_start = x - (x % 9)
  9.times do |i|
    res << row_start + i
  end
  res
end

def affected_cols(x)
  res = []
  col_start = x - (x - (x % 9))
  9.times do |i|
    res << col_start + i*9
  end
  res
end

def affected_box(x)
  res = []
  left = x - (x % 3)
  s = left - 9 * ((left / 9) % 3)
  3.times do |x|
    res << s 
    res << s + 1
    res << s + 2
    s += 9
  end
  res
end

def affected(x)
  res = []
  res += affected_rows(x)
  res += affected_cols(x)
  res += affected_box(x)
  res.uniq.sort
end

