namespace :db do
  desc "Seeding data"
  task seeding: :environment do
    if Rails.env.production?
      puts "Do not running in 'Production' task"
    else
      %w[db:drop db:create db:migrate].each do |task|
        Rake::Task[task].invoke
      end
      puts "create township"
      townships = ["Cau Giay", "Hoan Kiem", "Ba Đinh", "Dong Da", "Thanh Xuan",
        "Hoang Mai", "Tay Ho"]

      townships.each do |township|
        Township.create! name: township
      end

      puts "create pipeline"
      pipelines = ["electricLine", "waterLine", "subwayLine", "internetLine"]

      pipelines.each do |pipeline|
        PipeLine.create! name: pipeline, description: "this is a line!", size_safe: 1
      end

      puts "create Lines"
      # byebug
      Line.create! name: "Electtric01", pipe_line_id: 1
      Line.create! name: "Electtric02", pipe_line_id: 1

      puts "create marks"

      path1 = [
        {lat: 21.041651, lng: 105.790629},
        {lat: 21.041617, lng: 105.790835},
        {lat: 21.041606, lng: 105.790987},
        {lat: 21.041603, lng: 105.791075},
        {lat: 21.041608, lng: 105.791182},
        {lat: 21.041606, lng: 105.791280},
        {lat: 21.041609, lng: 105.791395},
        {lat: 21.041612, lng: 105.791510},
        {lat: 21.041611, lng: 105.791581},
        {lat: 21.041624, lng: 105.791774},
        {lat: 21.041716, lng: 105.791771},
        {lat: 21.041824, lng: 105.791767},
        {lat: 21.041897, lng: 105.791766},
        {lat: 21.042025, lng: 105.791762},
        {lat: 21.044069, lng: 105.792722},
        {lat: 21.044069, lng: 105.793175},
        {lat: 21.044049, lng: 105.793594},
        {lat: 21.043758, lng: 105.793601},
        {lat: 21.043483, lng: 105.793616},
        {lat: 21.043051, lng: 105.793621},
        {lat: 21.043045, lng: 105.793153},
        {lat: 21.043045, lng: 105.792717}
      ]
      path2 = [
        {lat: 21.043472, lng: 105.792906},
        {lat: 21.043043, lng: 105.792902},
        {lat: 21.043049, lng: 105.793617},
        {lat: 21.042679, lng: 105.793630},
        {lat: 21.042651, lng: 105.792906}
      ]

      path1.each_with_index do |mark, index|
        Mark.create! lat: mark[:lat], lng: mark[:lng], height: 0, line_id: 1, index_mark: index
      end

      path2.each_with_index do |mark, index|
        Mark.create! lat: mark[:lat], lng: mark[:lng], height: 0, line_id: 2, index_mark: index
      end

      puts "create user"
        User.create! email: "admin@gmail.com", password: "123456", password_confirmation: "123456"
    end
  end
end
