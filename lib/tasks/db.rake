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
        PipeLine.create! name: pipeline, description: "this is a line!", size_safe: 30
      end

      puts "create Lines"
      # byebug
      Line.create! name: "Electtric01", struction_id: 1, struction_type: PipeLine.name
      Line.create! name: "Electtric02", struction_id: 1, struction_type: PipeLine.name

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
          [21.046020, 105.790307, 100],
          [21.046056, 105.797152, 100],
          [21.042908, 105.797191, 100]
        ],
        [
          [21.046059, 105.791379, 100],
          [21.046059, 105.791379, 100],
          [21.045589, 105.790659, 100],
          [21.045120, 105.790669, 100]
        ],
        [
          [21.046063, 105.791635, 100],
          [21.044494, 105.791719, 100],
          [21.044466, 105.792691, 100],
          [21.043481, 105.792703, 100],
          [21.042923, 105.792697, 100],
          [21.042660, 105.792926, 100]
        ],
        [
          [21.044805, 105.791718, 100],
          [21.044785, 105.792687, 100],
          [21.043464, 105.792701, 100],
          [21.043503, 105.793629, 100],
          [21.044043, 105.793594, 100]
        ],
        [
          [21.045128, 105.790333, 100],
          [21.045089, 105.796637, 100]
        ],
        [
          [21.046121, 105.797529, 100],
          [21.042870, 105.797596, 100],
          [21.042824, 105.796683, 100],
          [21.041663, 105.794510, 100],
          [21.041601, 105.790380, 100]
        ],
        [
          [21.040602, 105.790471, 100],
          [21.040523, 105.794530, 100],
          [21.039026, 105.795925, 100],
          [21.039742, 105.797654, 100],
          [21.042867, 105.797585, 100]
        ],
        [
          [21.045639, 105.792675, 100],
          [21.045652, 105.796622, 100],
          [21.042919, 105.796678, 100]
        ],
        [
          [21.045249, 105.792703, 100],
          [21.045210, 105.797124, 100],
          [21.042841, 105.797152, 100]
        ],
        [
          [21.044780, 105.795186, 100],
          [21.044741, 105.796315, 100],
          [21.043244, 105.796329, 100],
          [21.043231, 105.795158, 100]
        ],
        [
          [21.058848, 105.783094, 100],
          [21.056124, 105.782300, 100],
          [21.053781, 105.781828, 100],
          [21.046127, 105.781254, 100],
          [21.041834, 105.780950, 100]
        ],
        [
          [21.041834, 105.780950, 100],
          [21.041648, 105.786157, 100],
          [21.041601, 105.790367, 100]
        ],
        [
          [21.041601, 105.790367, 100],
          [21.043458, 105.790290, 100],
          [21.046173, 105.790290, 100]
        ],
        [
          [21.046066, 105.784294, 100],
          [21.045244, 105.784307, 100],
          [21.043554, 105.786322, 100],
          [21.041648, 105.786169, 100]
        ]
      ]

      def check_intersect_line line1
        Line.all.where.not(id: line1.id).each do |line|
          values = LineMeeting.checking line1, line
          if values
            values.each do |value|
              line1.intersect_marks.create! lat: value[:lat], lng: value[:lng], second_line_id: line.id, height: value[:height]
            end
          end
        end
      end

      paths.each_with_index do |path, index|
        line = Line.create! name: "path#{index}", struction_id: rand(1..4),
          color: "#%06x" % (rand * 0xffffff), struction_type: PipeLine.name, radius: 5
        path.each do |position|
          line.marks.create! lat: position[0], lng: position[1], height: position[2]
        end
        check_intersect_line line
      end

      puts "create user"
        User.create! email: "admin@gmail.com", password: "123456", password_confirmation: "123456"
    end
  end
end
