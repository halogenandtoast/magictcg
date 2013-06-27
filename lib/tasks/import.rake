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
