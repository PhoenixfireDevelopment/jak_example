# Role based permissions
class Role < ApplicationRecord
  belongs_to :company

  validates :name, uniqueness: { case_sensitive: false, scope: [:company_id] }, presence: true
  validates :company, presence: true

  scope :ordered, -> { order('roles.name ASC') }

  # Search for Roles, server side
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
