require 'yaml'


require '.\\security'

fileHash = {}
instance = Security.new
puts "    local do arquivo:"
print "\n                     "
local = gets.chomp

puts "     Key:"
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

#descompactação
#Na folder temp
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

#despejar todos os arquivos
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

#RUN THAT BITCH
system "cd temp/#{fileHash[:info][:folder]} & start #{fileHash[:info][:folder]}.rb"
