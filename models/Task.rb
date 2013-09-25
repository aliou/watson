class Task < ActiveRecord::Base
  ONE_WEEK = 7 * 24 * 60 * 60

  belongs_to :list
  validates :list, presence: true

  after_initialize do |task|
    task.due_date ||= Time.now + ONE_WEEK
  end

  def missed?
    self.due_date < Time.now && !finished?
  end

  def finished?
    !self.finished_at.nil?
  end
end

