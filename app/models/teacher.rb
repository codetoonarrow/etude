class Teacher < ApplicationRecord
  belongs_to :user
  has_many :lessons
  has_many :availability_ranges
  has_many :students, through: :lessons

  validates :subject, :postal_code, presence: true
  validates :price, numericality: {only_integer: true}


  def first_name
    User.find(self.user_id).first_name
  end

  def last_name
    User.find(self.user_id).last_name
  end

  def email
    User.find(self.user_id).email
  end

  def available?(time)
    if lessons.length > 0
      lessons.each do |l|
        if l.time == time
          return false
        end
      end
    end
    return true
  end
end
