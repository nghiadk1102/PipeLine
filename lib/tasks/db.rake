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

      paths = [
        [
          [21.046020, 105.790307],
          [21.046056, 105.797152],
          [21.042908, 105.797191]
        ],
        [
          [21.046059, 105.791379],
          [21.046059, 105.791379],
          [21.045589, 105.790659],
          [21.045120, 105.790669]
        ],
        [
          [21.046063, 105.791635],
          [21.044494, 105.791719],
          [21.044466, 105.792691],
          [21.043481, 105.792703],
          [21.042923, 105.792697],
          [21.042660, 105.792926]
        ],
        [
          [21.044805, 105.791718],
          [21.044785, 105.792687],
          [21.043464, 105.792701],
          [21.043503, 105.793629],
          [21.044043, 105.793594]
        ],
        [
          [21.045128, 105.790333],
          [21.045089, 105.796637]
        ],
        [
          [21.046121, 105.797529],
          [21.042870, 105.797596],
          [21.042824, 105.796683],
          [21.041663, 105.794510],
          [21.041601, 105.790380]
        ],
        [
          [21.040602, 105.790471],
          [21.040523, 105.794530],
          [21.039026, 105.795925],
          [21.039742, 105.797654],
          [21.042867, 105.797585]
        ],
        [
          [21.045639, 105.792675],
          [21.045652, 105.796622],
          [21.042919, 105.796678]
        ],
        [
          [21.045249, 105.792703],
          [21.045210, 105.797124],
          [21.042841, 105.797152]
        ],
        [
          [21.044780, 105.795186],
          [21.044741, 105.796315],
          [21.043244, 105.796329],
          [21.043231, 105.795158]
        ],
        [
          [21.058848, 105.783094],
          [21.056124, 105.782300],
          [21.053781, 105.781828],
          [21.046127, 105.781254],
          [21.041834, 105.780950]
        ],
        [
          [21.041834, 105.780950],
          [21.041648, 105.786157],
          [21.041601, 105.790367]
        ],
        [
          [21.041601, 105.790367],
          [21.043458, 105.790290],
          [21.046173, 105.790290]
        ],
        [
          [21.046066, 105.784294],
          [21.045244, 105.784307],
          [21.043554, 105.786322],
          [21.041648, 105.786169]
        ]
      ]

      paths.each_with_index do |path, index|
        line = Line.create! name: "path#{index}", pipe_line_id: rand(1..4),
          color: "#%06x" % (rand * 0xffffff)
        path.each do |position|
          line.marks.create! lat: position[0], lng: position[1], height: 0
        end
      end

      puts "create user"
        User.create! email: "admin@gmail.com", password: "123456", password_confirmation: "123456"
    end
  end
end
