FactoryBot.define do
  factory :pipe_line do
    name FFaker::Product.model
    description FFaker::Tweet.body
    size_safe Random.rand(10)
  end
end
