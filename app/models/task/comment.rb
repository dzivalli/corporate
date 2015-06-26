class Task::Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  counter_culture :task, column_name: 'total_elapsed_time', delta_column: 'elapsed_time'

  validates :task, presence: true
  validates :user, presence: true
  validates :content, presence: true

  scope :ordered, ->{ order(id: :desc) }

  def elapsed_time_hours
    elapsed_time.to_i / 1.hour
  end

  def elapsed_time_hours=(v)
    update_elapsed_time v.to_i, elapsed_time_minutes
  end

  def elapsed_time_minutes
    elapsed_time.to_i % 1.hour / 1.minute
  end

  def elapsed_time_minutes=(v)
    update_elapsed_time elapsed_time_hours, v.to_i
  end

  private

  def update_elapsed_time(hours, minutes)
    self.elapsed_time = hours * 1.hour + minutes * 1.minute
  end
end