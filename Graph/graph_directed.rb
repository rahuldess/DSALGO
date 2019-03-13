module Graph
  class Edge
    attr_accessor :src, :dest, :weight

    def initialize(src:, dest:, weight:)
      @src = src
      @dest = dest
      @weight = weight
    end
  end

  class Vertex
    attr_accessor :value, :neighbors

    def initialize(value:)
      @value = value
      @neighbors = {}
    end
  end

  class Directed
    attr_accessor :vertices, :edges

    def initialize
      @vertices = {} 
      @edges = []
    end

    def add_vertex(value:)
      vertices[value] = Graph::Vertex.new(value: value)
      vertices
    end

    def add_edge(src:, dest:, weight: 0)
      if vertices.key?(src) && vertices.key?(dest)
        vertices[src].neighbors[dest] = weight
        edges << Graph::Edge.new(src: src, dest: dest, weight: weight)
      else
        puts "Either of source/destination vertex is missing"
        return
      end
    end

    def get_edges
      edges
    end

    def get_vertices
      @vertices.keys
    end

    def get_vertex(value:)
      vertices[value].inspect
    end
  end
end

###############################
#           ADT               #
###############################

#graph = Graph::Directed.new
#graph.add_vertex(value: 'A')
#graph.add_vertex(value: 'B')
#graph.add_vertex(value: 'C')
#graph.add_edge(src: 'C', dest: 'A', weight: 2)
#graph.add_edge(src: 'A', dest: 'B')
#graph.add_edge(src: 'B', dest: 'A')
#puts graph.vertices


