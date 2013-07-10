class CardVersion < ActiveRecord::Base
  belongs_to :card_set
  belongs_to :card

  delegate :name, :color, :types, to: :card
  default_scope { order "(substring(number, '^[0-9]+'))::int ASC, substring(number, '[^0-9].*$') ASC" }

  def scan_url
    if ENV['LOCAL']
      scan_path
    else
      "https://s3.amazonaws.com/magictcg-development#{scan_path}"
    end
  end

  private

  def scan_path
    "/scans/#{card_set.abbreviation}/#{image_url}.full.jpg"
  end
end
