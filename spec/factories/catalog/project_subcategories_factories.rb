FactoryBot.define do
  factory :project_subcategory, class: 'Catalog::ProjectSubcategory' do
    association :category, factory: :project_category
    sequence(:title) { |n| "Subcategory #{n}" }
  end
end
