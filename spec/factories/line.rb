FactoryBot.define do
  factory :line do
    name FFaker::Product.model
    description FFaker::Tweet.body
    pipe_line_id pipe_line
    color FFaker::Color.hex_code
  end
end
