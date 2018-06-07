class QuickLink < ActiveRecord::Base
  acts_as_positioned
  scope :sorted, lambda { order(:position) }


  def <=>(link)
    position <=> link.position
  end
end
