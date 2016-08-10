class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]

  has_many :diaries
  has_many :projects, through: :diaries

  after_create :make_current_diary

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end      
  end

  def make_current_diary
    diary = self.diaries.create
    self.current_diary = diary
    diary
  end

  def current_diary
    if self.current_diary_id
      Diary.find(self.current_diary_id)
    else 
      nil
    end
  end

  def current_diary=(diary) 
    if diary.is_a?(Diary)
      self.current_diary_id = diary.id
    else
      self.current_diary_id = nil
    end
    self.save
  end

  def worst_week
    self.diaries.max {|a,b| a.hours <=> b.hours}
  end

  def current_period_hours
    if self.current_diary
      self.current_diary.hours
    else
      0
    end
  end

  def lifetime_hours
    self.diaries.inject(0) {|sum, x| sum + x.hours}
  end
  
end
