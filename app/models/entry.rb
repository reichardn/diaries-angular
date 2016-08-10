class Entry < ActiveRecord::Base

  belongs_to :diary
  belongs_to :project

  enum day: [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]
  validates :minutes, :numericality => { :greater_than => 0 }
  validates :project, presence: true

  accepts_nested_attributes_for :project, :reject_if => lambda { |c| c[:name].blank? }

  def hours
    (self.minutes.to_f/60).round(2)
  end

end
