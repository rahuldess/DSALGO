require_relative 'graph_library'

####### Tip ####################
# 1. Pick any random vertex
# 2. Start exploring the vertex
# 3. Keep marking encountered vertices as visited.
# 4. If No children/Explored all vertices then push to sorted stack.
# 6. Print the same order as "sorted stack" pops.
################################

module Graph
  class SortingTopological
    attr_accessor :graph, :visited, :stack

    def initialize(graph:)
      @graph   = graph.vertices
      @visited = Set.new
      @stack   = []
    end

    def sort
      graph.each do | vertex, weight |
        if !visited.member?(vertex)
          dfs(current: vertex)
        end
      end
      stack.each { |elem| print "#{elem} ->" }
    end

    private

    def dfs(current:)
      visited.add(current)

      neighbors = graph[current].neighbors
      neighbors.each do |node, weight|
        dfs(current: node) if !visited.member?(node)
      end
      stack.push(current)
    end
  end
end

graph = Graph::Directed.new
graph.add_vertex(value: 'A')
graph.add_vertex(value: 'B')
graph.add_vertex(value: 'C')
graph.add_vertex(value: 'D')
graph.add_vertex(value: 'E')
graph.add_edge(src: 'A', dest: 'C')
graph.add_edge(src: 'B', dest: 'C')
graph.add_edge(src: 'B', dest: 'E')
graph.add_edge(src: 'C', dest: 'D')

topological = Graph::SortingTopological.new(graph: graph)
topological.sort
