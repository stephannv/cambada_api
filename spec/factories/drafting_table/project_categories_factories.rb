FactoryBot.define do
  factory :project_category, class: 'DraftingTable::ProjectCategory' do
    sequence(:title) { |n| "Category #{n}" }
  end
end
