#encoding: UTF-8

#******Security Virtual Machine******* Version 0.6
# Need to be the same version;
# In the compacted file will be the version of the SVM
# after the compacting, the 'svm.rb' file will be overrated by new code
# instead of a compacter will be descompacter and run the program
$version = "0.6"



require 'yaml'

class Security
  attr_accessor :key
  attr_reader :text
  attr_accessor :fodersHash
  def initialize
    @key = ""
    @text = []
    @code_text = ""
  end

  #Nome da pasta deverá ser o nome do arquivo de inicialização
  def createInstanceFolder folderPath, newFileName, key
      @@folderPath = folderPath
      @@newFileName = newFileName
      @key = key
      @@key = key
      makeKey




      scff (tramsform @@folderPath), (getFolder @@folderPath), @@newFileName

  end

  def getFather fileDir
    getFather = IO.readlines(fileDir)[0]
    getFather = ((getFather.match /#<folder:(.*?)>/)[1].delete " ")

    return getFather
  end

  def getFolder fileDir

    getPack = getFather fileDir

    @@folderPath = ( ( fileDir.match /(.*?)#{getPack}/ ) )[0]
    return @@folderPath
  end

  def tramsform fileDir
    getPack = IO.readlines(fileDir)[0]
    getPack = ((getPack.match /#<folder:(.*?)>/)[1].delete " ")

    fileHash = {info: nil}


    if (fileDir.include? getPack)

      folder = ( ( fileDir.match /(.*?)#{getPack}/ ) )[0]

      fileHash[:prnc] = folder

      Dir.chdir(folder)
      fileS = Dir.glob('*').select {|f|
        File.file? f
      }

      #Compila todos os aquivos da Father Folder
      fileHash[:filesFF] = fileS
      fileS.each { |f|
        fileHash[("#{f}".to_sym)] = (secure (File.read fileHash[:prnc] + "\\#{f}"))
      }

      allFolders = []
      allSubFolders = []
      Dir["**/"].each{ |directoryT|
        allFolders << (fileHash[:prnc] + "\\" + directoryT.gsub("/", "\\"))#get all sub folders in a array
        allSubFolders << directoryT.gsub("/", "\\")
      }

      fileHash[:allFolders] = allSubFolders

      timer = 0
      allFolders.each {|foldered|
          $folderOfNow = foldered
          Dir.chdir(foldered)
          Dir.glob('*').each { |f|
              if File.file? f
                  fileHash["\\#{allSubFolders[timer]}#{f}".to_sym] = (secure (File.read  "#{$folderOfNow}" + "#{f}"))
              end
          }
          timer += 1
      }

      fileHash[:info] = {svm_version: $version, folder: "#{getPack}"}

      #------------------------------
      return fileHash
      #------------------------------
    else
      return "erro not find path with the same name of the program"
    end
  end
  #security compiler for forlder xD legal né?
  def scff text, folderName, newName
    newName = folderName + "\\" + newName.to_s
    f = File.new((newName + ".svm"), "w")
      f.puts YAML.dump(text)
    f.close
  end


  #---------------------------------------------
  def createInstance filePath, newFileName, key
    @@filePath = filePath
    @@newFileName = newFileName
    @key = key
    @@key = key
    makeKey

    sc filePath, newFileName

    pathNow = File.dirname filePath

    File.open(pathNow + "\\#{newFileName}.rb", "w"){|f|
      f.puts "#|svm #{$version}",
      " ",
      "require '#{File.absolute_path __FILE__}'",
      " ",
      "s#{newFileName} = Security.new",
      "s#{newFileName}.key = '#{@@key}'",
      "    ",
      "#Initialize the program",
      "s#{newFileName}.svm '#{newFileName}'"
    }

  end








  def secure text
     makeKey #get the current Key
     begin
       @code_text = ""
       @text = []
       text.each_byte{ |byte|
          @text << (byte  + @Key.round - 63)
       }
       ##Codeficated
       @text.each{|c|
         @code_text << c.to_i.round.chr
       }
       return @code_text
     rescue
       @code_text = ""
       @text = []
       text.each_byte{ |byte|
          @text << (byte  + @Key.round - 100)
       }
       ##Codeficated
       @text.each{|c|
         @code_text << c.to_i.round.chr
       }
       return @code_text
     rescue
       @code_text = ""
       @text = []
       text.each_byte{ |byte|
         @text << (byte  + @Key.round - 50)
       }
       ##Codeficated
       @text.each{|c|
         @code_text << c.to_i.round.chr
       }
       return @code_text
     rescue
       @code_text = ""
       @text = []
       text.each_byte{ |byte|
         @text << (byte  + @Key.round + 100)
       }
       ##Codeficated
       @text.each{|c|
         @code_text << c.to_i.round.chr
       }
       return @code_text
     end
  end

  #decode
  def desecure text=@code_text #Array
    begin
      makeKey
      # "back in original form:"
      # from YAML File later
      decoded = ""
      text.each_byte { |charB|
        decoded << ( charB.round - @Key.round + 63).to_i.round.chr
      }
      return decoded
    rescue
      decoded = ""
      text.each_byte { |charB|
        decoded << ( charB.round - @Key.round + 100).to_i.round.chr
      }
      return decoded
    rescue
      decoded = ""
      text.each_byte { |charB|
        decoded << ( charB.round - @Key.round + 50).to_i.round.chr
      }
      return decoded
    rescue
      decoded = ""
      text.each_byte { |charB|
        decoded << ( charB.round - @Key.round - 100).to_i.round.chr
      }
      return decoded
    end
  end

  private
  def makeKey
    @tempKey = 0.0
    @key = @key.to_s
    @key.each_byte { |byte|
      @tempKey += byte
    }
    @Key = @tempKey / @key.length
  end

  public
  def svm(yamlFile)
    compiled = YAML.load(File.open(yamlFile + ".svm"))
    eval(desecure compiled)
  end

  def sc fileName, newName="oneTable"
    newName = (File.dirname fileName) + "\\" + newName.to_s
    text = secure(File.read(fileName))#file name must be the whole intire path of the file
    File.open((newName + ".svm"), "w") { |f|
      f.puts YAML.dump(text)
    }
  end
end
