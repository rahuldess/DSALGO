require_relative 'graph_library'

####### Tip ####################
# 1. Same as dijkstras algorithm. 
# 2. Only difference is, change in slight logic in 'relaxation' method 
# 3. Instead of checking dist_sheet(u) + weight(u,v) < dist_sheet(v), 
#    Just check for weight(u,v) < dist_sheet(v) because in prims 
#    you are checking edges minimum edge and NOT minimum distance.
################################

module Graph
  class MstPrims
    attr_reader   :start
    attr_accessor :graph, :distance_sheet, :visited, :short_path

    def initialize(start:, graph:)
      @graph   = graph.vertices
      @visited = Set.new
      @distance_sheet = {}
      @start   = start
      @short_path = []
    end

    def mst
      prepare_distance_sheet(graph: graph)
      # Iterate over graph 
      until visited.size == graph.size
        min_dist_vertex = min_distance(distance_sheet)
        explore(min_dist_vertex: min_dist_vertex)
        visited.add(min_dist_vertex)
      end
      min_path
    end

    def min_path
      distance_sheet.each do |vertex, data|
        next if vertex == start
        print "#{data[:parent]} -> #{vertex}, " 
      end
    end

    private 

    # Explore neighbors of selected vertex
    def explore(min_dist_vertex:)
      graph[min_dist_vertex].neighbors.each do |neighbor, weight|
        if !visited.member?(neighbor) && weight < distance_sheet[neighbor][:distance]
          distance_sheet[neighbor][:distance] = weight
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

graph.add_edge(src: 'A', dest: 'B', weight: 4)
graph.add_edge(src: 'B', dest: 'D', weight: 6)
graph.add_edge(src: 'A', dest: 'C', weight: 1)
graph.add_edge(src: 'B', dest: 'C', weight: 2)
graph.add_edge(src: 'C', dest: 'D', weight: 3)
graph.add_edge(src: 'D', dest: 'E', weight: 5)
graph.add_edge(src: 'C', dest: 'E', weight: 9)

prims = Graph::MstPrims.new(graph: graph, start: 'A')
prims.mst
