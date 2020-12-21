# Represents a Sales lead
class Lead < ApplicationRecord
  belongs_to :assignable, class_name: 'User'
  belongs_to :company

  validates :name, uniqueness: { case_sensitive: false, scope: [:company_id] }, presence: true
  validates :company, presence: true

  scope :ordered, -> { order(name: :asc) }

  # Search leads, server side
  def self.search(query)
    query.strip!
    t          = arel_table
    conditions = t[:name].matches("%#{query}%")
    where(conditions)
  end

  # String representation
  def to_s
    name
  end
end
