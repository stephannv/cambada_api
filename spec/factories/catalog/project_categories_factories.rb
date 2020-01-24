FactoryBot.define do
  factory :project_category, class: 'Catalog::ProjectCategory' do
    sequence(:title) { |n| "Category #{n}" }
  end
end
