class Song < ApplicationRecord
  validates :title, presence: true
  validates :title, uniqueness: { scope: :release_year, message: "Should not be repeated by the same artist in the same year." }
  validates :released, inclusion: { in: [true, false] }

  with_options if: :released? do |song|
    song.validates :release_year, presence: true
    song.validates :release_year, numericality: {
      less_than_or_equal_to: Date.current.year
    }
  end

  def released?
    released
  end

end
