temp = Dir["temp/**/*"]

temp.each { |file|
  begin;if File.file? file;File.delete file;end
  rescue;puts "Not was possible to delete the file #{file}";exit
  end
}

temp = Dir["temp/**"]
temp.each { |dir|
  begin;if File.directory? dir;Dir.delete dir;puts dir;end
  rescue; system "rmdir /s /q #{dir}"
  rescue; puts "Not was possible to delete the directory #{dir}";exit
  end
}
