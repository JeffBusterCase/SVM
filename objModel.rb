require 'yaml'


require '.\\security'

fileHash = {}
instance = Security.new
puts "    file path:"
print "\n                     "
local = gets.chomp

puts "     Key to descompile:"
print "\n        "
key = gets.chomp

instance.key = key

fileHash = YAML.load File.read(local)
fileHash.each { |key, value|
  puts "\n ===== ===== ===== ====== ===== =====\n", key
  begin
    if key != :prnc
      puts instance.desecure value
    else
      puts value
    end
  rescue
    puts value
  end
}

#Descompile in Temp folder
$FILEHASH = fileHash

if !( Dir.exist? (".\\temp\\#{$FILEHASH[:info][:folder]}") )
  Dir.mkdir(".\\temp\\#{$FILEHASH[:info][:folder]}")
end

def makeFolders
  n = 0
  t = []
  $FILEHASH[:allFolders].each { |e|
    tmp = e.reverse.sub("\\", "").reverse
    tmp != nil ? ( t << e.reverse.sub("\\", "").reverse ) : ()
  }
  while n < t.length
    puts n
    begin
      Dir.mkdir ".\\temp\\#{$FILEHASH[:info][:folder]}\\#{t[n]}"
    rescue
      puts $!, $!.backtrace
    end
    n += 1
  end
end

def makeFile arq, *text
  begin
    tmp = File.new(( ".\\temp\\#{$FILEHASH[:info][:folder]}\\#{arq}"), "w" )
  rescue
    tmp = File.new(( ".\\temp\\#{$FILEHASH[:info][:folder]}#{arq}"), "w" )
  end
    tmp.puts text
  tmp.close
end

puts "==!== ==!== ==!== ==!== ==!== ==!== ==!== ==!== ==!==\n"
makeFile "info.txt",  fileHash[:info].to_s,
"\n\nFiles:\n#{ fileHash[:filesFF].to_s}",
"\n\nFolders:\n#{ fileHash[:allFolders].to_s}"

#Put all files and folders
makeFolders
fileHash.each { |key, value|
  puts "\n\n =====* *=====* *=====* *======* *=====* *=====\n", key
  begin
    if key != :prnc
      puts instance.desecure value
      makeFile key, (instance.desecure value)
    else
      puts value
      makeFile key, value
    end
  rescue
    puts value
    makeFile key, value

  end
}

#go to the folder and run the principal program (With the same name as the folder)
system "cd temp/#{fileHash[:info][:folder]} & start #{fileHash[:info][:folder]}.rb"
