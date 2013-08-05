def step1(x)
  if x==1 
     puts "it was all a dream"
  end
  return 2
end

def step2(x)
  if x==2
     puts "i used to read"
  end 
  x += 1
  y = step3(x)
  return y
end

def step3(x)
  if x==3 
    puts "Word Up magazine"
  end
  return 4
end

def step4(x)
  if x==4
     puts %w(SaltnPepa HeavyD).join(' and ')
  end
  puts "up in the #{step5(x+=1)}"
  return step5(x+=2)
end

def step5(x)
  if x==5 
    return "limousine"
  else
    puts "hanging pictures on my wall"
    return 7
  end
end

def step6(x)
  stuff= []
  if x==7 then 
    stuff.push("Saturday Rap Attack", "Mr. Magic", "Marley Marl")
  elsif x==66
    stuff.push()
  end

  return stuff.join(', ')
end
#step4(step2(step1(1))) = 7
# step6(step4(step2(step1(1)))) = [ "Saturday Rap Attack, Mr. Magic, Marley Marl"]
#step7(step4(step2(step1(1)))) = my tape
#step8(step7(step4(step2(step1(1))))) = rock
#step8(step8(step7(step4(step2(step1(1)))))) = popped
# step8(step8(step8(step7(step4(step2(step1(1))))))) = ["smokin'", "sippin'"]
#step10(step8(step8(step8(step7(step4(step2(step1(1)))))))) = ["smokin'", ["weed", "bamboo"], "sippin'"]
# step11(step10(step8(step8(step8(step7(step4(step2(step1(1))))))))) = ["smokin'", ["weed", "bamboo"], "sippin'", "private stock"]
#step11(step11(step10(step8(step8(step8(step7(step4(step2(step1(1)))))))))) = "way back"
# step12(step11(step11(step10(step8(step8(step8(step7(step4(step2(step1(1))))))))))) = 9
# step13(step12(step11(step11(step10(step8(step8(step8(step7(step4(step2(step1(1)))))))))))) =10
# step13(step13(step12(step11(step11(step10(step8(step8(step8(step7(step4(step2(step1(1))))))))))))) = "remember"
# step14(step13(step13(step12(step11(step11(step10(step8(step8(step8(step7(step4(step2(step1(1)))))))))))))) = ["r", "m", "mb", "r"]
# step12(step14(step13(step13(step12(step11(step11(step10(step8(step8(step8(step7(step4(step2(step1(1))))))))))))))) = ["r", "m", "mb", "r"]
#step15(step12(step14(step13(step13(step12(step11(step11(step10(step8(step8(step8(step7(step4(step2(step1(1)))))))))))))))) = "rhyme tight"
# step15(step15(step12(step14(step13(step13(step12(step11(step11(step10(step8(step8(step8(step7(step4(step2(step1(1))))))))))))))))) = ["paid", "worldtrade"]
# step17(step15(step15(step12(step14(step13(step13(step12(step11(step11(step10(step8(step8(step8(step7(step4(step2(step1(1)))))))))))))))))) = [["a", "a"], ["paid", "worldtrade"]]
# step16(step17(step15(step15(step12(step14(step13(step13(step12(step11(step11(step10(step8(step8(step8(step7(step4(step2(step1(1)))))))))))))))))))
# step16(step17(step15(step15(step12(step14(step13(step13(step12(step11(step11(step10(step8(step8(step8(step7(step4(step2(step1(1))))))))))))))))))) = 10
# step28(step16(step17(step15(step15(step12(step14(step13(step13(step12(step11(step11(step10(step8(step8(step8(step7(step4(step2(step1(1))))))))))))))))))))=10
# step13(step28(step16(step17(step15(step15(step12(step14(step13(step13(step12(step11(step11(step10(step8(step8(step8(step7(step4(step2(step1(1))))))))))))))))))))) = "remember"
#step18(step13(step28(step16(step17(step15(step15(step12(step14(step13(step13(step12(step11(step11(step10(step8(step8(step8(step7(step4(step2(step1(1)))))))))))))))))))))) = "remember when i used to eat"
# step19(step10(step18(step13(step28(step16(step17(step15(step15(step12(step14(step13(step13(step12(step11(step11(step10(step8(step8(step8(step7(step4(step2(step1(1)))))))))))))))))))))))) = remember when i used to eat sardines for dinner when i used to eat
# step19(step10(step18(step13(step28(step16(step17(step15(step15(step12(step14(step13(step13(step12(step11(step11(step10(step8(step8(step8(step7(step4(step2(step1(1)))))))))))))))))))))))) = ["Ron", "G", "Brucey", "B", "Kid", "Capri", "Lovebug", "Starsky"]
# 

def step7(x)
  puts "Every #{step6(x)}"
  return "my tape"
end

def step8(x)
  if x=="my tape"
    puts "i let my tape rock"
    return "rock"
  elsif x=="rock"
    puts "til my tape popped"
    return "popped"
  else
    return %w(smokin' sippin') 
  end
end

def step9(x)
  if x.length / 2 == 1
    return step10(x.length, x)
  end
end

def step10(x)
  y = %w(weed bamboo sardines)
  if x.length == 2
    return x.insert(1,y[0..1])
  elsif x.length == 27
    return x.split('').insert(x.length, " #{y[2]} for dinner")
  else
    return y[2]
  end
end

def step11(x)
  if x.length % 2 != 0
    return x.push("private stock")
  elsif x.length % 2 == 0
    puts "#{x[0]} #{x[1].join(' and ')}, #{x[2]} on #{x[3]}"
    return "way back"
  end
end

def step12(x)
  if x.length == 8
    puts "#{x}, when I had the red and black lumberjack"
    return x.length+1
  else
    puts "you never thought that hiphop would take it this far"
    return x
  end
end

def step13(x)
  if x%3==0
    puts "with the hat to match"
    return x+1
  elsif x%5 ==0
    return "remember"
  end
end

def step14(x)
  puts "#{x} Rappin' Duke,"
  (x.length / 4).times  do
    puts " duh-ha "
  end
  return x.split('e')
end

def step15(x)
  if x.length == 11
    puts "now i'm in the limelight cuz I #{x}"
    return %w(paid worldtrade)
  else
    return "rhyme tight"
  end
end

def step16(x)
  if x[0].all? {|char| char == 'a'}
    puts "bout to get #{x[1][0]}, blow up like the #{x[1][1]}"
  end
  return 10
end 

def step17(x)
  words = []
  x.each do |y|
    words << y.split('').last(3).first
  end
  return [words, x]
end

def step18(x)
  return "#{x} when i used to eat"
end

def step19(x)
  puts step18(x.join(''))
  return %w(Ron G Brucey B Kid Capri Lovebug Starsky)
end

def step20(x)
  yield x.each_slice(2).to_a
  return "i thought you would"
end

def step21(x)
  x.each do |y|
    x[x.index(y)] = y.join(' ')
  end
  return "peace to #{x.join(', ')}"
end

def step22(x)
  puts "#{yield} like #{step24(x).join(' ')}"
  return "call"
end

def step23(x)
  return "i'm blowing up"
end

def step24(x)
  return step25(x.split(' ').map { |x| x == "you" ? "i" : x})
end

def step25(x)
  x[0] = "you"
  return x
end

def step26(x)
  puts "#{x} the crib"
  w = []
  w << yield + "number"
  w << yield + "hood"
  puts w.join(', ')
  return %w(it's good)
end

def step27(x)
  return x.insert(1, 'all') if x.all? { |a| a.length == 4}
end

def step28(x)
  puts "born sinner, the opposite of a winner"
  return x
end
####### JUST FLOW

x=1