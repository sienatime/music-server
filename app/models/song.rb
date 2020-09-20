class Song < ApplicationRecord
  belongs_to :artist
  belongs_to :album, optional: true

  validates :title, presence: true

  def path
    "#{folder}/#{filename}"
  end
end
