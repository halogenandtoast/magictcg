class CardVersion < ActiveRecord::Base
  belongs_to :card_set
  belongs_to :card

  delegate :name, :color, :types, to: :card

  def scan_url
    path = "/scans/#{card_set.abbreviation}/#{image_url}.full.jpg"
    if ENV['LOCAL']
      path
    else
      "https://s3.amazonaws.com/magictcg-development#{path}"
    end
  end

  def add_alternate_art count, suffix = ''
    if suffix == ''
      alternates = (count - 1).times.map do
        dup.tap { |alternate| alternate.save }
      end
      ([self] + alternates).each_with_index do |version, index|
        new_image_url = version.image_url.gsub(".full.jpg", "#{index+1}.full.jpg")
        version.update(image_url: new_image_url)
      end
    else
      alternates = count.times.map do
        dup.tap { |alternate| alternate.save }
      end
      alternates.each_with_index do |version, index|
        new_image_url = version.image_url.gsub(/(\d)?\.full\.jpg$/) do |match|
          "#{index+1}#{suffix}.full.jpg"
        end
        version.update(image_url: new_image_url)
      end
    end
  end
end
