require_relative 'graph_library'
require_relative '/../util_library'

####### Tip ####################
# 1. Use Queue for BFS.
# 2. Always pick next node from the queue itself.
# 3. Keep track of visited nodes
# 3. Return result once Queue is empty 
################################

module Graph
  class BFS
    attr_accessor :graph, :visited, :queue

    def initialize(start:, graph:)
      @graph   = graph.vertices
      @visited = Set.new
      @queue   = []
      valid?(start) ? @queue.push(start) : return
    end

    def search
      until queue.empty?
        current = queue.shift

        if !visited.member?(current)
          # Iterating over neighors
          graph[current].neighbors.each do | neighbor, weight |
            if !visited.member?(neighbor)
              queue.push(neighbor)
            end
          end

          visited.add(current)
          print "#{current} ->"
        end
      end
    end

    private

    def valid?(start)
      @graph.key?(start)
    end
  end
end

###############################
#           ADT               #
###############################

graph = Graph::Directed.new
graph.add_vertex(value: 'A')
graph.add_vertex(value: 'B')
graph.add_vertex(value: 'C')
graph.add_vertex(value: 'D')
graph.add_vertex(value: 'E')
graph.add_vertex(value: 'F')
graph.add_edge(src: 'A', dest: 'B')
graph.add_edge(src: 'A', dest: 'C')
graph.add_edge(src: 'A', dest: 'E')
graph.add_edge(src: 'B', dest: 'C')
graph.add_edge(src: 'C', dest: 'D')
graph.add_edge(src: 'B', dest: 'F')
graph.add_edge(src: 'B', dest: 'D')

bfs_search = Graph::BFS.new(start: 'B', graph: graph)
bfs_search.search
