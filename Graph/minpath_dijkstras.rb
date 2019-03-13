require_relative 'graph_library'

####### Tip ####################
# 1. Initialize hash with all vertices mapped to Infinity
#    distance except the start vertex ( mapped to 0 ).
# 2. Select the minimum distance vertex and mark it visited. ( Use Priority Queue )
# 3. Explore edges of selected vertex ( relaxation ).
# 4. trim the path until the destination vertex
# 5. return distance & trimmed path
################################

module Graph
  class MinPathDijkstras
    attr_reader   :start, :dest
    attr_accessor :graph, :distance_sheet, :visited, :short_path

    def initialize(start:, dest:, graph:)
      @graph   = graph.vertices
      @visited = Set.new
      @distance_sheet = {}
      @start   = start
      @dest    = dest
      @short_path = []
    end

    def shortest_distance
      prepare_distance_sheet(graph: graph)
      # Iterate over graph 
      until visited.size == graph.size
        min_dist_vertex = min_distance(distance_sheet)
        explore(min_dist_vertex: min_dist_vertex)
        visited.add(min_dist_vertex)
      end
      return distance_sheet[dest][:distance]
    end

    def min_path
      stack = []
      array = []

      stack.push(dest)
      current = dest

      until current == start do
        current = distance_sheet[current][:parent]
        stack.push(current)
      end

      until stack.empty? do
        array << stack.pop
      end
      array
    end

    private 

    # Explore neighbors of selected vertex
    def explore(min_dist_vertex:)
      puts "-------2"
      graph[min_dist_vertex].neighbors.each do |neighbor, weight|
        if !visited.member?(neighbor) && distance_sheet[min_dist_vertex][:distance] + weight < distance_sheet[neighbor][:distance]
          distance_sheet[neighbor][:distance] = distance_sheet[min_dist_vertex][:distance] + weight
          distance_sheet[neighbor][:parent] = min_dist_vertex
        end
      end
    end

    def prepare_distance_sheet(graph:)
      graph.each do |vertex, weight|
        distance = (vertex == start ? 0 : Float::INFINITY)
        distance_sheet[vertex] = { distance: distance, parent: nil }
      end
    end

    # TODO: Replace this logic to use Priority Queues
    def min_distance(distance_sheet)
      min_distance = nil 
      min_vertex   = nil

      distance_sheet.each do |key, value|
        if !visited.member?(key)
          if min_distance.nil?
            min_distance = value[:distance]
            min_vertex = key
          elsif value[:distance] < min_distance
            min_distance = value[:distance]
            min_vertex = key
          end
        end
      end
      min_vertex
    end
  end
end


graph = Graph::Undirected.new
graph.add_vertex(value: 'A')
graph.add_vertex(value: 'B')
graph.add_vertex(value: 'C')
graph.add_vertex(value: 'D')
graph.add_vertex(value: 'E')
graph.add_vertex(value: 'F')
graph.add_vertex(value: 'G')
graph.add_vertex(value: 'H')
graph.add_vertex(value: 'I')
graph.add_edge(src: 'A', dest: 'B', weight: 4)
graph.add_edge(src: 'A', dest: 'H', weight: 8)
graph.add_edge(src: 'B', dest: 'C', weight: 8)
graph.add_edge(src: 'B', dest: 'H', weight: 11)
graph.add_edge(src: 'H', dest: 'I', weight: 7)
graph.add_edge(src: 'H', dest: 'G', weight: 1)
graph.add_edge(src: 'C', dest: 'I', weight: 2)
graph.add_edge(src: 'I', dest: 'G', weight: 6)
graph.add_edge(src: 'G', dest: 'F', weight: 2)
graph.add_edge(src: 'C', dest: 'F', weight: 4)
graph.add_edge(src: 'C', dest: 'D', weight: 7)
graph.add_edge(src: 'D', dest: 'F', weight: 14)
graph.add_edge(src: 'D', dest: 'E', weight: 9)
graph.add_edge(src: 'F', dest: 'E', weight: 10)

dijkstras = Graph::MinPathDijkstras.new(graph: graph, start: 'A', dest: 'G')
puts "Minimum distance is #{dijkstras.shortest_distance}"

dijkstras.min_path.each do |item|
  print "#{item} ->"
end
