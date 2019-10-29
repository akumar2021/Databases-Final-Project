task :query => [:environment] do
  # One GROUP BY Query
  puts Ngc.all.group_by{|i| i.con}
  # One report which pulls data from at least three tables
  
  #puts Messier.find_by(name: "M44")._id

  Messier.all.each do |object|
    puts object.to_a.inspect
    puts Ngc.find_by(_id: NgcM.find_by(messier_id: object._id).ngc_id).to_a.inspect
    puts Constellation.find_by(_id: NgcM.find_by(messier_id: object._id).constellation_id).to_a.inspect
    puts Supernova.find_by(ngc_id: Ngc.find_by(_id: NgcM.find_by(messier_id: object._id).ngc_id)._id).to_a.inspect
    puts
  end

end
