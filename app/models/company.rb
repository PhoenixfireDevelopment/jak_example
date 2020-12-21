# Represents a Tenant resource
class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :roles, dependent: :destroy
  has_many :leads, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :ordered, -> { order('companies.name ASC') }

  # Search companies, server side
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
