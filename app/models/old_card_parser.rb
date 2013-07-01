class OldCardParser
  KEYS = [
    "Name", "Card Name", "CardName", "Card Title", "Card Type", "Cost",
    "Type", "Rarity", "Set/Rarity", "Pow/Tgh", "Rules Text", "Artist",
    "Flavor Text", "Type & Class", "Color", "Card Color", "Casting Cost",
    "Set Number", "Card #"
  ]
  def initialize(data, set_name)
    @set_name = set_name
    card_details = {}
    last_key = nil
    data.lines.each do |line|
      next if line.strip == ""
      key, value = line.split(/:\s+/, 2).map(&:strip)
      if value && KEYS.include?(key)
        card_details[key] = value
        last_key = key
      elsif KEYS.exclude?(key)
        card_details[last_key] += " " + line.strip
      else
        card_details[last_key] += " " + key
      end
    end
    @title = (card_details['Card Name'] || card_details['Card Title'] || card_details['CardName'] || card_details["Name"]).gsub(/\s+/, ' ')

    puts card_details.inspect
    @rarity_string = get_rarity(card_details['Rarity'] || card_details['Set/Rarity'])
  end

  def rarity(rare_matcher = /(Rare|R)/)
    if @rarity_string =~ /(Special|Mythic|MythicRare|Mythic Rare|M)/
      "Mythic"
    elsif @rarity_string =~ rare_matcher
      "Rare"
    elsif @rarity_string =~ /(Uncommon|U)/
      "Uncommon"
    else
      "Common"
    end
  end

  def card
    Card.where("name ILIKE ?", title).first!
  end

  private

  def title
    if @title =~ /, The$/
      "The #{@title.gsub(/, The$/, '')}"
    else
      @title
    end
  end

  def get_rarity rarity_string
    return "Common" if rarity_string == nil || rarity_string.strip == ""
    rarities = rarity_string.split(",")
    rarity = if rarities.length == 1
               rarities[0]
             else
               rarities.find { |rarity| rarity =~ /#{@set_name}/i }
             end
    begin
      rarity.gsub(/#{@set_name}/i, "").strip.capitalize
    rescue
      binding.pry
      raise
    end
  end
end

