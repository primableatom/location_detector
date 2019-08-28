# Algorithim Shamelessly Copied from http://jakescruggs.blogspot.com/2009/07/point-inside-polygon-in-ruby.html

module LocationDetector
  class Polygon

    def initialize(vertices = [])
      @vertices = vertices
    end

    def size
      @vertices.size
    end
    
    def contains_point?(point)
      c = false
      i = -1
      j = self.size - 1
      while (i += 1) < self.size
        if ((@vertices[i].y <= point.y && point.y < @vertices[j].y) || 
            (@vertices[j].y <= point.y && point.y < @vertices[i].y))
          if (point.x < (@vertices[j].x - @vertices[i].x) * (point.y - @vertices[i].y) / 
                        (@vertices[j].y - @vertices[i].y) + @vertices[i].x)
            c = !c
          end
        end
        j = i
      end
      return c
    end
  end
    
end
