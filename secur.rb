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
    puts "    (no extension on the new name*! )   "
    puts "    new file name:"
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
  puts 'ERROR:'
  puts "file or folder not finded '#{filePath}'"
  puts $!
  puts $!.backtrace
end
