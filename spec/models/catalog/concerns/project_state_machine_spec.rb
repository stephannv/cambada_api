require 'rails_helper'

RSpec.describe Catalog::Project, type: :model do
  describe 'Transitions' do
    context 'when state is draft' do
      subject { create(:project, state: :draft) }

      it { is_expected.to transition_from(:draft).to(:live).on_event(:publish) }
      it { is_expected.to_not allow_transition_to(:canceled) }
      it { is_expected.to_not allow_transition_to(:banned) }
    end

    context 'when state is live' do
      subject { create(:project, state: :live) }

      it { is_expected.to transition_from(:live).to(:finished).on_event(:finish) }
      it { is_expected.to transition_from(:live).to(:canceled).on_event(:cancel) }
      it { is_expected.to transition_from(:live).to(:banned).on_event(:ban) }

      it { is_expected.to_not allow_transition_to(:draft) }
    end

    context 'when state is canceled' do
      subject { create(:project, state: :canceled) }

      it { is_expected.to_not allow_transition_to(:draft) }
      it { is_expected.to_not allow_transition_to(:live) }
      it { is_expected.to_not allow_transition_to(:banned) }
    end

    context 'when state is banned' do
      subject { create(:project, state: :banned) }

      it { is_expected.to_not allow_transition_to(:draft) }
      it { is_expected.to_not allow_transition_to(:live) }
      it { is_expected.to_not allow_transition_to(:canceled) }
    end
  end

  describe 'Callbacks' do
    describe '#after_all_transitions' do
      let!(:project) { create(:project, state: :draft) }

      it 'creates a project state transition' do
        expect do
          project.publish!
        end.to change(Catalog::ProjectStateTransition, :count).by(1)
        first_transition = project.state_transitions.first
        last_transition = project.state_transitions.last
        expect(first_transition).to_not be_most_recent
        expect(first_transition.to_state).to eq 'draft'
        expect(last_transition).to be_most_recent
        expect(last_transition.to_state).to eq 'live'
        expect(last_transition.from_state).to eq 'draft'
      end
    end
  end
end
