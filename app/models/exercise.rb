class Exercise < ApplicationRecord
  belongs_to :user

  alias_attribute :workout_details, :workout
  alias_attribute :activity_date, :workout_date

  validates :duration_in_min, numericality: { greater_than: 0 }
  validates_presence_of :workout_details, :activity_date

  scope :last_seven_days, -> { where("workout_date > ?", 7.days.ago) }
end
