desc "Import sets and cards"
task import: :environment do
  require 'json'
  json = JSON.parse(File.read(Rails.root.join("lib", "AllSets-x.json")))
  json.each do |abbreviation, set|
    set_name = set["name"]
    card_set = CardSet.find_or_create_by!(name: set_name, abbreviation: abbreviation)
    set["cards"].each do |card_json|
      card_name = card_json["name"]
      card_colors = card_json["colors"] || []
      rarity = card_json["rarity"]
      imageName = card_json["imageName"]
      card = Card.find_or_create_by!(name: card_name, color: card_colors.join(" "))
      card.card_versions.create(card_set_id: card_set.id, rarity: rarity, image_url: imageName)
    end
  end
end
