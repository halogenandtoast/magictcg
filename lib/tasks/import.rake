desc "Import sets and cards"
task import: :environment do
  ActiveRecord::Base.transaction do
    card_set_hash = {}
    xml = Nokogiri::XML(File.open(Rails.root.join("lib", "cards.xml")).read)
    xml.search("sets set").each do |set_node|
      longname = set_node.at("longname").content.strip
      abbreviation = set_node.at("name").content.strip
      card_set = CardSet.find_or_create_by!(name: longname, abbreviation: abbreviation)
      card_set_hash[abbreviation] = card_set
    end
    xml.search("cards card").each do |card_node|
      name = card_node.at("name").content
      card = Card.find_or_create_by(name: name)

      card_node.search("set").each do |card_set_node|
        url = card_set_node['picURL']
        card_set = card_set_hash[card_set_node.content.strip]
        CardVersion.find_or_create_by(card: card, card_set: card_set, image_url: url)
      end
    end
  end
end

task images: :environment do
  require 'open-uri'
  require 'thread'

  class Pool
    def initialize size
      @size = size
      @jobs = Queue.new
      @pool = Array.new(@size) do |i|
        Thread.new do
          Thread.current[:id] = i
          catch(:exit) do
            loop do
              job, args = @jobs.pop
              job.call(*args)
            end
          end
        end
      end
    end

    def schedule *args, &block
      @jobs << [block, args]
    end

    def shutdown
      @size.times do
        schedule { throw :exit }
      end
      @pool.map(&:join)
    end
  end
  pool = Pool.new(15)
  image_dir = Rails.root.join("public", "images")
  unless File.exists?(image_dir)
    FileUtils.mkdir(image_dir, verbose: false)
  end
  ActiveRecord::Base.transaction do
    finished = Dir.glob("public/images/*.jpg").map { |s| File.basename(s, ".*").to_i }
    CardVersion.where(id: finished).where("image_url NOT LIKE '%jpg'").update_all("image_url = CONCAT('/images/', id, '.jpg')")
    CardVersion.where.not(id: finished).map do |version|
      pool.schedule do
        uri = URI.parse(version.image_url)
        temp = open(uri)
        File.open(File.join(image_dir, "#{version.id}.jpg"), "wb") do |file|
          file.write temp.read
        end
        version.update(image_url: "/images/#{version.id}.jpg")
      end
    end
    at_exit { pool.shutdown }
  end
end

task fix_missing: :environment do
  require 'nokogiri'
  require 'open-uri'
  xml = Nokogiri::XML(File.read(Rails.root.join("lib", "cards.xml")))
  missing = [19563, 19906, 19995, 20084, 20100, 20352, 20360, 20392, 20402, 20406, 20417, 20418, 20422, 20432, 20434, 20439, 20447, 20449, 20453, 20455, 20459, 20505, 20830, 20869, 20886, 20903, 20966, 21033, 21057, 21058, 21060, 21066, 21078, 21100, 21122, 21289]
  missing_card_versions = CardVersion.where(id: missing).includes(:card, :card_set)
  missing_card_versions.each do |card_version|
    name = card_version.card.name
    set = card_version.card_set.abbreviation
    uri = xml.xpath("//cards/card[child::name[contains(text(), '#{name}')]]/set[contains(text(), '#{set}')]")[0]['picURL']
    image_dir = Rails.root.join("public", "images")
    puts "Grabbing: #{uri}"
    temp = open(uri)
    File.open(File.join(image_dir, "#{card_version.id}.jpg"), "wb") do |file|
      file.write temp.read
    end
  end
end
