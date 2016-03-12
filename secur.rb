#
#
#
require '.\\security'
instance = Security.new
##----------

puts "  File path: "
filePath = gets.chomp






begin

  if File.exist? filePath
    #continue
    puts "    (no extension on the new name*! )   ",
    "    new file name:"
    print "                 :"
    newName = gets.chomp
    puts "    key:"
    print "       :"
    key = gets.chomp
    puts "wait..\n"
    instance.createInstance filePath, newName, key
    puts "finished"
  else
    puts "file or folder not finded '#{filePath}'"
  end
rescue
  puts 'ERROR:',
  "file or folder not finded '#{filePath}'",
  $!, 
  $!.backtrace
end
