require 'mathn'

class LineMeeting
  class << self
    def checking line1, line2
      return false unless line1.max_lat && line1.min_lat && line2.max_lat && line1.min_lat && line1.max_lng && line2.min_lng && line2.max_lng && line1.min_lng
      if line1.max_lat < line1.min_lat || line2.max_lat < line1.min_lat
        return false
      end

      if line1.max_lng < line2.min_lng || line2.max_lng < line1.min_lng
        return false
      end
      list_marks_line1 = line1.marks.pluck :lat, :lng, :height
      list_marks_line2 = line2.marks.pluck :lat, :lng, :height
      list_intersect = []
      list_marks_line1.each_with_index do |value1, index1|
        break if index1 >= list_marks_line1.size - 1
        list_marks_line2.each_with_index do |value2, index2|
          break if index2 >= list_marks_line2.size - 1
          result =  checkLineIntersection(value1[0], value1[1], list_marks_line1[index1 + 1][0], list_marks_line1[index1 + 1][1], value2[0], value2[1], list_marks_line2[index2 + 1][0], list_marks_line2[index2 + 1][1])
          if result[:onLine1] && result[:onLine2]
            z1 = height_intersect_mark({x: value1[0].to_f, y: value1[1].to_f, z: value1[2].to_f}, {x: list_marks_line1[index1 + 1][0].to_f, y: list_marks_line1[index1 + 1][1].to_f, z: list_marks_line1[index1 + 1][2].to_f}, {x: result[:x].to_f, y: result[:y].to_f})

            z2 = height_intersect_mark({x: value2[0].to_f, y: value2[1].to_f, z: value2[2].to_f}, {x: list_marks_line2[index2 + 1][0].to_f, y: list_marks_line2[index2 + 1][1].to_f, z: list_marks_line2[index2 + 1][2].to_f}, {x: result[:x].to_f, y: result[:y].to_f})
            if (z1 - z2) < (line1.size_safe + line2.size_safe)
              list_intersect << {lat: result[:x], lng: result[:y]}
            end
          end
        end
      end

      return list_intersect
    end

    private

    def height_intersect_mark markX, markY, markZ
      if markX[:z] < markY[:z]
        a = markX
        markX = markY
        markY = a
      end

      markX1_markY1 = Math.sqrt((markX[:x] - markY[:x])**2 + (markX[:y] - markY[:y])**2)
      markZ1_markY1 = Math.sqrt((markY[:x] - markZ[:x])**2 + (markY[:y] - markZ[:y])**2)

      return ((markZ1_markY1 * (markX[:z] - markY[:z])) / markX1_markY1) + markY[:z]
    end

    def checkLineIntersection line1StartX, line1StartY, line1EndX, line1EndY, line2StartX, line2StartY, line2EndX, line2EndY
      line1StartX = line1StartX.to_f
      line1StartY = line1StartY.to_f
      line1EndX = line1EndX.to_f
      line1EndY = line1EndY.to_f
      line2StartX = line2StartX.to_f
      line2StartY = line2StartY.to_f
      line2EndX = line2EndX.to_f
      line2EndY = line2EndY.to_f
      result = {x: nil, y: nil, onLine1: false, onLine2: false}
      denominator = ((line2EndY - line2StartY) * (line1EndX - line1StartX)) - ((line2EndX - line2StartX) * (line1EndY - line1StartY))
      return result if denominator == 0
      a = line1StartY - line2StartY
      b = line1StartX - line2StartX
      numerator1 = ((line2EndX - line2StartX) * a) - ((line2EndY - line2StartY) * b)
      numerator2 = ((line1EndX - line1StartX)) * a - ((line1EndY - line1StartY) * b)
      a = numerator1 / denominator
      b = numerator2 / denominator

      result[:x] = line1StartX + (a * (line1EndX - line1StartX))
      result[:y] = line1StartY + (a * (line1EndY - line1StartY))

      x = line2StartX + (b * (line2EndX - line2StartX))
      y = line2StartX + (b * (line2EndY - line2StartY))

      if (a > 0 && a < 1)
        result[:onLine1] = true
      end

      if (b > 0 && b < 1)
        result[:onLine2] = true
      end
       return result
    end
  end
end
