require 'active_support/concern'

module Catalog
  module Concerns
    module ProjectStateMachine
      extend ActiveSupport::Concern

      included do
        include AASM

        after_create :create_project_state_transition

        aasm column: 'state', enum: false do
          state :draft, initial: true
          state :live
          state :finished
          state :canceled
          state :banned

          after_all_transitions :create_project_state_transition

          event :publish do
            transitions from: :draft, to: :live
          end

          event :finish do
            transitions from: :live, to: :finished
          end

          event :cancel do
            transitions from: :live, to: :canceled
          end

          event :ban do
            transitions from: :live, to: :banned
          end
        end
      end

      def create_project_state_transition
        state_transitions.find_by(most_recent: true).try(:update, most_recent: false)
        state_transitions.create!(
          from_state: aasm.from_state,
          to_state: aasm.to_state || :draft,
          event: aasm.current_event,
          most_recent: true
        )
      end
    end
  end
end
