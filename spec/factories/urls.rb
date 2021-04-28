FactoryBot.define do
  factory :url do
    link { Faker::Internet.url }
    _alias { Faker::Internet.slug }
    user { FactoryBot.create(:user) }
  end
end
