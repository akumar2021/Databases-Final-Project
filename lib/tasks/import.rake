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

def getClassIds(classes)
  output = []
  for i in 0..arr.count()
    output << Classification.find_by({name: splitClasses(classes)[i]})._id
  end
  return output
end

def extractNGC(ngc)
  ngc.sub!("NGC", "")
  while ngc.include?(" ")
    ngc.sub!(" ", "")
  end

  return ngc
end

desc "Imports data from CSV files"
task :import => [:environment] do
   
  print"Importing Constellations..."

  file = "data/Constellations.csv"

  CSV.foreach(file, :headers => true) do |row|
    Constellation.find_or_create_by ({
      name: row[0],
      abbreviation: row[1].upcase,
      origin: row[2],
      meaning: row[3]
    })
    print "."
  end
  puts

  print"Importing NgcM Relationships..."
  
  file = "data/NgcMs.csv"
  
  CSV.foreach(file, :headers => true) do |row|
    puts row[1]
    NgcM.find_or_create_by({
      ngc_id: row[1],
      messier_id: row[2],
      constellation_id: Constellation.find_by({abbreviation: row[3]})._id
    })
  end
  puts

  print"Importing NGC..."
  
  file = "data/NGCs.csv"

  CSV.foreach(file, :headers => true) do |row|
    Ngc.find_or_create_by({
      _id: extractNGC(row[0]),
      name: "NGC " + extractNGC(row[0]),
      alternate_names: row[1],
      type: row[2],
      NgcM_id: NgcM.find_by({ngc_id: row[0]})._id,
      constellation_id: Constellation.find_by({_id: NgcM.find_by({ngc_id: row[0].upcase}).constellation_id}).name,
      con: row[3],
      ra: row[4],
      d: row[5],
      mag: row[6],
      subr: row[7],
      size_max: row[8],
      size_min: row[9],
      type_class: row[10],
      brstr: row[11],
      bchm: row[12],
      ngc_descr: row[13],
      notes: row[14]
    })
  end
  puts

  print"Importing Messier..."
  
  file = "data/Messiers.csv"

  CSV.foreach(file, :headers => true) do |row|
    Messier.find_or_create_by({
      _id: row[0],
      name: "M"+row[0],
      NgcM_id: NgcM.find_by({messier_id: row[0].to_i})._id,
      ngc_name: "NGC"+row[1],
      con: Constellation.find_by({_id: NgcM.find_by({messier_id: row[0].upcase}).constellation_id}).name,
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

  file = "data/Supernovae.csv"

  CSV.foreach(file, :headers => true) do |row|
    Supernova.find_or_create_by({
      _id: row[0].sub("SN",""),
      name: row[0],
      disc_date: row[1],
      mmax: row[2],
      ngc_id: Ngc.find_by({name: row[3]})._id,
      ngc_name: row[3],
      ra: row[4],
      d: row[5],
      type: row[6]
    })
    print"."
  end

  puts

  print"Importing Stars..."

  file = "data/Stars.csv"

  CSV.foreach(file, :headers => true) do |row|
    Star.find_or_create_by({
      _id: row[0],
      hip: row[1],
      hd: row[2],
      hr: row[3],
      gl: row[4],
      bf: row[5],
      proper: row[6],
      ra: row[7],
      d: row[8],
      dist: row[9],
      pmra: row[10],
      pmd: row[11],
      mag: row[12],
      absmag: row[13],
      classification_id: Constellation.find_by({abbreviation: row[14]})._id,
      spect: splitClasses(row[14]),
      ci: row[15],
      x: row[16],
      y: row[17],
      z: row[18],
      vx: row[19],
      vy: row[20],
      vz: row[21],
      constellation_id: Constellation.find_by({abbreviation: row[22]})._id,
      con: Constellation.find_by({abbreviation: row[22].upcase}).name,
      comp: row[23],
      comp_primary: row[24],
      lum: row[25],
      var: row[26],
      var_min: row[27],
      var_max: row[28]
    })
    print "."
  end
  puts
  

  print"Importing Classifications..."

  file = "data/Classifications.csv"

  CSV.foreach(file, :headers => true) do |row|
    Classification.find_or_create_by({
      name: row[1]
    })
    print "."
  end
  puts


  puts("Sucessfully imported all data!")
end

