class Notice < ActiveRecord::Base

  def self.displayed
    Notice.where(display: true)
  end
end
