class Project < ActiveRecord::Base

  validates :name, uniqueness: true, presence: true

  has_many :entries
  has_many :diaries, through: :entries

end
