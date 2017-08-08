FactoryGirl.define do
  factory :wiki do
    title Faker::RickAndMorty.unique.character
    body Faker::RickAndMorty.unique.quote
  end
end
