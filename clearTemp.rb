temp = Dir["temp/**/*"]

temp.each { |file|
  begin;if File.file? file;File.delete file;end
  rescue;puts "Não foi possivel deletar o arquivo #{file}";exit
  end
}

temp = Dir["temp/**"]
temp.each { |dir|
  begin;if File.directory? dir;Dir.delete dir;puts dir;end
  rescue; system "rmdir /s /q #{dir}"
  rescue; puts "Não foi possivel deletar o directorio #{dir}";exit
  end
}
