class List < ActiveRecord::Base
  has_many :tasks, inverse_of: :list
  validates :name, uniqueness: true, presence: true

  def create_task(option)
    Task.create(:text => option[:text],
                :due_date => option[:due_date],
                :list_id => self.id)
  end

  def missed_tasks
    self.tasks.find_all {|t| t.missed?}
  end

  def finished_tasks
    self.tasks.find_all {|t| t.finished?}
  end

  def archive!
    self.archived_at = Time.now
    self.save!
  end

  def unarchive!
    self.archived_at = nil
    self.save!
  end

  def archived?
    !self.archived_at.nil?
  end

  def count
    self.tasks.count
  end
end
