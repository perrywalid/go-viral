class TiktokPost < ApplicationRecord
  belongs_to :user

  def day_of_week
    creation_date.strftime('%A')
  end

  def hour_of_day
    creation_date.strftime('%H').to_i
  end
end
