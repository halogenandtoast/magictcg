class CardSetImporter
  def initialize(name)
    @card_set = CardSet.named(name)
  end

  def update_scans
    fix_scan_images
    fix_doubles
    fix_lands
    fix_colons
  end

  def import_commander_rarity
    card_versions.where(rarity: nil).each do |v|
      begin
        rarity = v.card.card_versions.where.not(card_set_id: card_set.id).first.rarity
        v.update(rarity: rarity)
      rescue
        binding.pry
        raise
      end
    end
  end

  def import_rarity(rare_matcher = /(Rare|R)/)
    file_name = Rails.root.join("lib", "set_lists", "#{name.gsub(":", "")}.txt")
    card_names = File.open(file_name, "r:utf-8").read.split(/\r?\n\r?\n/)
    card_names.each { |card_name| update_rarity(card_name) }
  end

  private
  attr_reader :card_set

  def update_rarity card_name
    data = OldCardParser.new(card_name, name)
    card_version = card_versions.where(card_id: data.card)
    card_version.update_all(rarity: data.rarity)
  end

  def fix_scan_images
    card_versions.each do |card_version|
      name = "#{ActiveSupport::Inflector.transliterate(card_version.name).gsub('"', '')}.full.jpg"
      card_version.update(image_url: "/scans/#{abbreviation}/#{name}")
    end
  end

  def replace_part_of_image_name(part)
    matches = cards.where("name like ?", "%#{part}%")
    if matches.any?
      card_versions.where(card_id: matches.map(&:id)).each { |v| v.update(image_url: v.image_url.gsub(":", "")) }
    end
  end

  def fix_colons
    replace_part_of_image_name(":")
  end

  def fix_doubles
    replace_part_of_image_name(" // ")
  end

  def fix_lands
    %w(Forest Island Mountain Plains Swamp).each do |land|
      fix_land card_set.versions(land)
    end
  end

  def fix_land versions
    count = alternate_land_count versions
    if versions.length == 1 && count > 1
      versions.first.add_alternate_art(count)
    end
  end

  def alternate_land_count versions
    if versions.any?
      Dir.glob(scan_dir.join("#{land}[1-4].full.jpg")).count
    else
      0
    end
  end

  def scan_dir
    Rails.root.join.("public", "scans", abbreviation)
  end

  def card_versions
    card_set.versions
  end

  def abbreviation
    card_set.abbreviation
  end

  def name
    card_set.name
  end
end
