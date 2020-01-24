module Catalog
  class ProjectStateTransition < ApplicationRecord
    belongs_to :project

    validates :project_id, presence: true
    validates :to_state, presence: true
  end
end
