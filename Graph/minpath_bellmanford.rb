require_relative 'graph_library'

####### Tip ####################
# 1. Initialize hash with all vertices mapped to Infinity
#    distance except the start vertex ( mapped to 0 ).
# 2. Select random vertex & relax edges of selected vertex ( relaxation ).
# 3. Repeat Step 2 until V-1 times.
# 4. If min distance still decreases after V-1 times. Then there is -ve Edge cycle in graph.
# 4. trim the path until the destination vertex
# 5. return distance & trimmed path
################################

module Graph
  class MinPathBellmanford
    attr_reader   :start, :dest
    attr_accessor :graph, :distance_sheet, :short_path

    def initialize(start:, dest:, graph:)
      @graph   = graph.vertices
      @distance_sheet = {}
      @start   = start
      @dest    = dest
      @short_path = []
    end

    def shortest_distance
      prepare_distance_sheet(graph: graph)
      # Iterating over graph V-1 times
      (graph.size - 1).times do
        graph.each { |vertex_name, vertex_node| relax(vertex: vertex_name) }
      end
      # Repeat One more time to check for -Ve Weight Cycle
      @old_sheet = Marshal.load(Marshal.dump(distance_sheet))
      if negative_cycle?
        return "\"Contains Negative Cycle\""
      else
        return @old_sheet[dest][:distance]
      end
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

    def negative_cycle?
      graph.each { |vertex_name, vertex_node| relax(vertex: vertex_name) }
      byebug
      @old_sheet != distance_sheet
    end

    # relax neighbors of selected vertex
    def relax(vertex:)
      graph[vertex].neighbors.each do |neighbor, weight|
        if distance_sheet[vertex][:distance] + weight < distance_sheet[neighbor][:distance]
          distance_sheet[neighbor][:distance] = distance_sheet[vertex][:distance] + weight
          distance_sheet[neighbor][:parent] = vertex
        end
      end
    end

    def prepare_distance_sheet(graph:)
      graph.each do |vertex, weight|
        distance = (vertex == start ? 0 : Float::INFINITY)
        distance_sheet[vertex] = { distance: distance, parent: nil }
      end
    end
  end
end


graph = Graph::Directed.new
graph.add_vertex(value: 'A')
graph.add_vertex(value: 'B')
graph.add_vertex(value: 'C')
graph.add_vertex(value: 'D')
graph.add_edge(src: 'A', dest: 'B', weight: 1)
graph.add_edge(src: 'B', dest: 'C', weight: 3)
graph.add_edge(src: 'C', dest: 'D', weight: 2)
graph.add_edge(src: 'D', dest: 'B', weight: -6)

bellmanford = Graph::MinPathBellmanford.new(graph: graph, start: 'A', dest: 'D')
puts "Minimum distance is #{bellmanford.shortest_distance}"

#bellmanford.min_path.each do |item|
#  print "#{item} ->"
#end
