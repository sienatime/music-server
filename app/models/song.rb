class Song < ApplicationRecord
  belongs_to :artist
  belongs_to :album, optional: true

  validates :title, presence: true
end
