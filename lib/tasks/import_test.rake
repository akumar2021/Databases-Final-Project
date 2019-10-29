require 'csv'

require File.expand_path('../config/environment', "development.rb")

def splitClasses (spect)
  while spect.include?(".")
    spect.sub!(".", "")
  end
  arr = spect.split("/")

  firstTwo = arr[0][0..1]
  if arr.count() > 1
    for i in 1.. arr.count()-1
      arr[i] = firstTwo + arr[i]
    end
  end

  return arr
end

desc "Imports data from CSV files"
task :import_test => [:environment] do
   
  print"Importing Constellations..."

  file = "data/test/Constellations.csv"

  CSV.foreach(file, :headers => true) do |row|
    Constellation.find_or_create_by ({
      name: row[1],
      abbreviation: row[2],
      origin: row[3],
      meaning: row[4]
    })
    print "."
  end
  puts

  print"Importing NgcM Relationships..."
  
  file = "data/test/Relationships.csv"

  CSV.foreach(file, :headers => true) do |row|
    NgcM.find_or_create_by({
      ngc_id: row[1],
      messier_id: row[2],
      constellation_id: Constellation.find_by({abbreviation: row[3]})._id
    })
    print"."
  end
  puts

  print"Importing NGC..."
  
  file = "data/test/NGC.csv"

  CSV.foreach(file, :headers => true) do |row|
    Ngc.find_or_create_by({
      _id: row[0],
      name: row[1],
      alternate_names: row[2],
      type: row[3],
      NgcM_id: NgcM.find_by({ngc_id: row[0]})._id,
      con: Constellation.find_by({_id: NgcM.find_by({ngc_id: row[0]}).constellation_id}).name,
      ra: row[6],
      d: row[7]
    })
    print "."
  end
  puts

  print"Importing Messier..."
  
  file = "data/test/Messier.csv"

  CSV.foreach(file, :headers => true) do |row|
    Messier.find_or_create_by({
      _id: row[0],
      name: "M"+row[0],
      NgcM_id: NgcM.find_by({messier_id: row[0].to_i})._id,
      ngc_name: "NGC"+row[1],
      con: Constellation.find_by({_id: NgcM.find_by({messier_id: row[0]}).constellation_id}).name,
      ra: row[3],
      d: row[4],
      mag: row[5],
      sec: row[6],
      type: row[7]
    })
    print "."
  end
  puts

  print"Importing Supernova..."

  file = "data/test/Supernova.csv"

  CSV.foreach(file, :headers => true) do |row|
    Supernova.find_or_create_by({
      _id: row[1].sub("SN",""),
      name: row[1],
      disc_date: row[2],
      mmax: row[3],
      ngc_id: Ngc.find_by({_id: row[4].sub("NGC ", "")})._id,
      ngc_name: Ngc.find_by({_id: row[4].sub("NGC ", "")}).name,
      ra: row[5],
      d: row[6]#,
      #type: row[6],
      #photo: row[7],
      #spec: row[8],
      #radio: row[9],
      #xray: row[10]
    })
    print"."
  end

  puts

  print"Importing Stars..."

  file = "data/test/Stars.csv"

  CSV.foreach(file, :headers => true) do |row|
    Star.find_or_create_by({
      _id: row[1],
      hip: row[1],
      proper: row[2],
      ra: row[3],
      d: row[4],
      dist: row[5],
      mag: row[6],
      absmag: row[7],
      spect: splitClasses(row[8]),
      bayer: row[9],
      constellation_id: Constellation.find_by({abbreviation: row[10]})._id,
      con: Constellation.find_by({abbreviation: row[10]}).name,
    })
    print "."
  end
  puts
  
=begin
  print"Importing Classifications..."

  file = "data/test/Classification.csv"

  CSV.foreach(file, :headers => true) do |row|
    Classification.find_or_create_by({
      name: row[1]
    })
    print "."
  end
  puts
=end

  puts("Sucessfully imported all data!")
end

