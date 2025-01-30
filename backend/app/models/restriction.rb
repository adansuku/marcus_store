class Restriction < ApplicationRecord
  belongs_to :source_part_option, class_name: 'PartOption'
  belongs_to :target_part_option, class_name: 'PartOption'

  validates :restriction_type, inclusion: { in: %w[requires excludes] }

  def excludes?
    self.restriction_type == 'excludes'
  end

  def requires?
    self.restriction_type == 'requires'
  end
end
