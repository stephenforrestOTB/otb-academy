require "open-uri"
require "nori"
require "nokogiri"
class PubFinder
  def initialize()
    @found_codes = []
    @datafile = "postcodedata.txt"
    if !File.file?(@datafile)
      p "Downloading Postcode Data"
      webdata = open("http://www.npemap.org.uk/data/fulllist").read
      open(@datafile, "wb") { |file|
          file.write(webdata)
      }
        #p "data from web"
    end
  end
  def find_postcodes(part)
    File.open(@datafile){ |file|
      file.find_all{|line| line.downcase.split(",")[0] == part}
    }
  end

  def find_specfic(part)
    @found_codes.each{ |line|
      if line.downcase.split(',')[1] == part
        p line
        return line
        break
      end
    }
    nil
  end
  def get_postcode_data(postcode)
    first,last = postcode.downcase.split(' ')
    @found_codes += find_postcodes(first)
    if @found_codes.size > 0
      if @found_codes.size > 1 && find_specfic(last)
          p "Found #{postcode} in database!"
          find_specfic(last)
      else
        p "Only #{first} could be found in database. Using that."
        @found_codes[0]
      end
    else
      p "The postcode #{postcode} could not be found"
      nil
    end
  end
  def find_num_of_pubs(dataline)
    parts = dataline.split(',')
    lat = parts[4].to_f
    lon = parts[5].to_f
    #"#{lon-0.025}, #{lat-0.025}, #{lon+0.025}, #{lat+0.025}"
    xmldata = open("http://api.openstreetmap.org/api/0.6/map?bbox=#{lon-0.025},#{lat-0.025},#{lon+0.025},#{lat+0.025}").read
    #parser = Nori.new
    pubtag = false
    data_arr = []
    xmldata.each_line{ |line|
        if line.include?('<tag k="amenity" v="pub"/>')
          pubtag = true
        end
        if pubtag && line.include?('<tag k="name"')
          data_arr << line
          pubtag = false
        end
    }
    pub_arr = [] #parser.parse(xmldata)
    data_arr.each{|dataline|
      pub_arr << dataline.split('"')[3]
    }
    p "There are #{pub_arr.size} pubs near your postcode:"
    pub_arr.each {|pub|
      p pub
    }
    pub_arr.size
  end
  def find_in(postcode)
    postcodedataline = get_postcode_data(postcode)
    if postcodedataline
      p find_num_of_pubs(postcodedataline)
    else
      p postcodedataline
    end
  end
end

finder = PubFinder.new
finder.find_in("m20 4sh")
