class Contract::Appendix < ActiveRecord::Base
  include AppendixRepository
  include WithAttachments

  belongs_to :contract
  belongs_to :contact_person, class_name: 'User'

  validates :order_number, presence: true
  validates :date, presence: true

  def to_s
    order_number.to_s
  end
end
