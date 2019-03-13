require_relative 'graph_library'

####### Tip ####################
# 1. Use Stack for DFS.
# 2. Keep track of visited nodes
# 3. Mark visited & push to stack once next node 
#    is selected
# 4. Pop from stack if all children of node is visited
#    or no children at all.
# 5. Return result once Stack is empty 
################################

module Graph
  class DFS
    attr_accessor :graph, :visited, :stack, :start

    def initialize(start:, graph:)
      @start   = start
      @graph   = graph.vertices
      @visited = Set.new
      @stack   = []
      valid?(@start) ? @stack.push(@start) && @visited.add(@start): return
    end

    def search
      current = start
      print "#{current} ->"

      until stack.empty?
        if !all_visited?(current)
          graph[current].neighbors.each do | neighbor, weight |
            if !visited.member?(neighbor)
              print "#{neighbor} ->"
              visited.add(neighbor)
              stack.push(neighbor)
              current = neighbor
              break
            end
          end
        else
          stack.pop
          current = stack.last
        end
      end
    end

    private

    def all_visited?(current)
      neighbors = graph[current].neighbors
      neighbors.all? { |neighbor, weight| visited.member?(neighbor) }
    end

    def valid?(start)
      @graph.key?(start)
    end
  end
end

###############################
#           ADT               #
###############################

graph = Graph::Undirected.new
graph.add_vertex(value: 'A')
graph.add_vertex(value: 'B')
graph.add_vertex(value: 'C')
graph.add_vertex(value: 'D')
graph.add_vertex(value: 'E')
graph.add_vertex(value: 'F')
graph.add_edge(src: 'A', dest: 'B')
graph.add_edge(src: 'B', dest: 'D')
graph.add_edge(src: 'D', dest: 'F')
graph.add_edge(src: 'F', dest: 'E')
graph.add_edge(src: 'C', dest: 'E')
graph.add_edge(src: 'A', dest: 'C')

dfs_search = Graph::DFS.new(start: 'A', graph: graph)
dfs_search.search
