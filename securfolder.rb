##first Line must be the folder name
#Ex:
###     #<folder: folderName>

require '.\\security.rb'

puts "(Entire Path*)",
     "File:"
fileDir = gets.chomp
instance = Security.new

if File.exist? fileDir
    puts "       New file name:"
    print "\n          "
    newfilename = gets.chomp
    puts "       Key:"
    print "\n      "
    key = gets.chomp
    begin
      instance.createInstanceFolder fileDir, newfilename, key
    rescue
      puts "-- #<folder: nameOfTheMainFolder> --not finded in the first line.*",
      $!,
      $!.backtrace
    end
else
  puts "Folder not finded"
end
