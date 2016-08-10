class Diary < ActiveRecord::Base

  belongs_to :user
  has_many :entries
  has_many :projects, through: :entries

  enum status: [:open, :submitted]

  def submit
    self.update(status: :submitted)
    self.user.make_current_diary
  end

  def hours
    ans = self.entries.inject(0) {|sum, x| sum + x.minutes}
    (ans.to_f/60).round(2)
  end

  def project_hours(project_id)
    ans = self.entries.inject(0) {|sum, x| (x.project_id == project_id) ? sum + x.minutes : sum}
    (ans.to_f/60).round(2)
  end

  def day_hours(day)
    ans = self.entries.inject(0) {|sum, x| (x.day == day) ? sum + x.minutes : sum}
    (ans.to_f/60).round(2)
  end

end
