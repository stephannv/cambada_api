FactoryBot.define do
  factory :project, class: 'Catalog::Project' do
    association :subcategory, factory: :project_subcategory
    sequence(:title) { |n| "Project #{n}" }
    project_type { Catalog::Project.project_types.values.sample }
    state { Catalog::Project.aasm.states.map(&:name).sample }
    short_description { Faker::Lorem.sentence }
    full_description { Faker::Lorem.paragraph(sentence_count: 30) }

    trait :all_or_nothing do
      project_type { :all_or_nothing }
      deadline { Faker::Date.between(from: Time.zone.today, to: 1.year.from_now) }
    end

    trait :flexible do
      project_type { :flexible }
      deadline { Faker::Date.between(from: Time.zone.today, to: 1.year.from_now) }
    end

    trait :subscription do
      project_type { :subscription }
      deadline { nil }
    end
  end
end
