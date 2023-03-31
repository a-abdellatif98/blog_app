FactoryBot.define do
  factory :post do
    title { 'Test Post' }
    body { 'This is a test post.' }
    published { true }
  end
end
