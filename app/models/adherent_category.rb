# frozen_string_literal: true
class AdherentCategory < ApplicationRecord
  include Seoable
  include Enablable

  # Configurations =============================================================
  acts_as_list

  # Associations ===============================================================
  has_many :adherents, -> { order(:position) }, dependent: :restrict_with_exception

  # Callbacks ==================================================================

  validates :title, presence: true

  # Scopes =====================================================================
  scope :having_adherents, -> { joins(:adherents).distinct }

  # Class Methods ==============================================================

  def self.apply_filters(params)
    klass = self
  end

  def self.apply_sorts(params)
    self.order(position: :asc)
  end


  # Instance Methods ===========================================================

  # private #=====================================================================
end
