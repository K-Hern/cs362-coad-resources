# Class: Ticket
# -------------
# Description: Create a ticket with a name, phone number, region id, resource category
class Ticket < ApplicationRecord

  belongs_to :region
  belongs_to :resource_category
  belongs_to :organization, optional: true

  validates_presence_of :name, :phone, :region_id, :resource_category_id
  validates_length_of :name, minimum: 1, maximum: 255, on: :create
  validates_length_of :description, maximum: 1020, on: :create
  validates :phone, phony_plausible: true

  scope :open, -> () { where closed: false, organization_id: nil }
  scope :closed, -> () { where closed: true }
  scope :all_organization, -> () { where(closed: false).where.not(organization_id: nil) }
  scope :organization, -> (organization_id) { where(organization_id: organization_id, closed: false) }
  scope :closed_organization, -> (organization_id) { where(organization_id: organization_id, closed: true) }
  scope :region, -> (region_id) { where(region_id: region_id) }
  scope :resource_category, -> (resource_category_id) { where(resource_category_id: resource_category_id) }

# Class Definition: open?
# ------------------------
# Checks if the ticket is open.
#
# @return [Boolean] true if the ticket is open, false otherwise
  def open?
    !closed
  end

# Class Definition: captured?
# ----------------------------
# Checks if the ticket is captured.
#
# @return [Boolean] true if the ticket is captured, false otherwise
  def captured?
    organization.present?
  end

# Class Definition: to_s
# -----------------------
# Returns a string representation of the ticket.
#
# @return [String] the string representation of the ticket
  def to_s
    "Ticket #{id}"
  end

end
