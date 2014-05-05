require "./affected"

def clear(h)
  puts "\e[#{h+1}A"
end

def render(asc)
  clear(9)
  asc.join('').scan(/........./).each do |line|
    puts line
  end
  #sleep(0.1) #out comment to see algorithm in action
end

def deep_clone(asc)
  return Marshal.load(Marshal.dump(asc))
end

def arc_con(x,v,d,asc) #let d[x] get value v
  ax = affected(x)
  ax.delete(x) #no need to update self.
  ax.each do |a|
    if asc[a] == 0 #only check if not assigned
      d[a].delete(v)
    end
  end
end

def arc_con_all(asc,d)
  81.times do |i|
    if asc[i] != 0
      arc_con(i,asc[i],d,asc)
    end
  end
end

def fc(asc,d)
  if no_zeros?(asc) then return "succes" end
  x = first_zero(asc)
  d_old = deep_clone(d)
  d[x].each do |v|
    arc_con(x,v,d,asc)
    asc[x] = v
    render(asc) # Just to see the progress
    try = fc(asc,d)
    if try == "failure"
      asc[x] = 0
      d = deep_clone(d_old)
    else
      return "succes"
    end
  end
  return "failure"
end

def first_zero(asc)
  asc.each_with_index do |var,i|
    if var == 0
      return i
    end
  end
  return -1
end

def no_zeros?(asc)
  return first_zero(asc) == -1
end

# init asc and d
domain = [1,2,3,4,5,6,7,8,9]
d = []
81.times do |x|
  d[x] = domain.clone
end

# clear space for solving
9.times do
  puts
end

#sudoku to solve:
asc = [
      0,0,0, 4,0,0, 8,0,0,
      0,0,0, 3,0,0, 0,0,0,
      3,8,0, 0,7,0, 0,4,9,
      4,7,0, 0,2,0, 3,0,0,
      9,0,0, 0,0,0, 0,0,5,
      0,0,5, 0,4,0, 0,9,6,
      6,9,0, 0,8,0, 0,5,7,
      0,0,0, 0,0,4, 0,0,0,
      0,0,7, 0,0,5, 0,0,0]

#ensure arc consistency on all start variables (define above)
arc_con_all(asc,d)

#Calculate and print solution
puts fc(asc,d)
