task :show => [:environment] do
  print("Constellations")
  puts
  puts Constellation.all.to_a.inspect.split(", #")
  puts

  print("NgcMs")
  puts
  puts NgcM.all.to_a.inspect.split(", #")
  puts

  print("Ngcs")
  puts
  puts Ngc.all.to_a.inspect.split(", #")
  puts 
  
  print("Messier")
  puts
  puts Messier.all.to_a.inspect.split(", #")
  puts

  print("Supernova")
  puts
  puts Supernova.all.to_a.inspect.split(", #")

  print("Stars")
  puts
  puts Star.all.to_a.inspect.split(", #")
  
end
