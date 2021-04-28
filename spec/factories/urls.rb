FactoryBot.define do
  factory :url do
    link { Faker::Internet.url }
    trait :without_link do
      link { nil }
    end

    _alias { Faker::Internet.slug }
    trait :without_alias do
      _alias { '' }
    end

    user { FactoryBot.create(:user) }
  end
end
