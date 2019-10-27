task :delete => [:environment] do
  puts "Constellation => " + Constellation.delete_all.to_s
  puts "NgcM => " + NgcM.delete_all.to_s
  puts "Ngc => " + Ngc.delete_all.to_s
  puts "Messier => " + Messier.delete_all.to_s
  puts "Supernova => " + Supernova.delete_all.to_s
  puts "Star => " + Star.delete_all.to_s
  print("Deleted all data!")
  puts
end
