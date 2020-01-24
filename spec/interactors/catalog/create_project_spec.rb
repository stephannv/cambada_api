require 'rails_helper'

RSpec.describe Catalog::CreateProject, type: :interactor do
  describe '.call' do
    subject(:result) { described_class.call(attributes: attributes) }

    context 'when attributes are valid' do
      let(:project_subcategory) { create(:project_subcategory) }
      let(:attributes) do
        build(:project, title: 'My Project', subcategory: project_subcategory)
          .attributes
          .with_indifferent_access
          .slice(:title, :project_subcategory_id, :project_type, :short_description)
      end

      it 'creates a new project' do
        expect { result }.to change(Catalog::Project, :count).by(1)
        expect(result).to be_a_success
        expect(result.project).to be_persisted
        expect(result.project).to be_a(Catalog::Project)
        expect(result.project.title).to eq 'My Project'
        expect(result.project.slug).to eq 'my-project'
        expect(result.project.project_subcategory_id).to eq project_subcategory.id
        expect(result.project.project_type).to eq attributes[:project_type].to_sym
        expect(result.project.short_description).to eq attributes[:short_description]
        expect(result.project.state.to_sym).to eq :draft
      end
    end

    context 'when attributes are invalid' do
      let(:attributes) { { title: '' } }

      it 'raises RecordInvalid error' do
        expect { result }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
