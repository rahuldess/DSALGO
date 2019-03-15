require_relative '../DisjointSet/disjointset_library'
require_relative 'graph_library'
require_relative '../util_library'

####### Tip ####################
# 1. Sort all edges in increasing weight order.
# 2. Make set's of each vertex.
# 3. If root(src) == root(dest)... Then ignore that edge.
# 4. If root(src) != root(dest)... Then "Union" and it to Minimum path result.
################################

module Graph
  class MstKruskal
    attr_accessor :graph, :short_path, :disjoint_set

    def initialize(graph:)
      @graph        = graph
      @short_path   = []
      @disjoint_set = DisjointSet::DisjointSet.new
    end

    def mst
      # Create 'Set' for every vertex.
      graph.get_vertices.each { |vertex| disjoint_set.make_set(value: vertex) }
      # Sort the edges of graph in increasing weight order
      sorted_edges = graph.get_edges.sort_by { |edge| edge.weight }

      # Iterate over each edge and pick only those edges which are not making circle
      sorted_edges.each do |edge|
        if disjoint_set.find_set(value: edge.src) != disjoint_set.find_set(value: edge.dest)
          disjoint_set.union(node_x: edge.src, node_y: edge.dest)
          short_path << [edge.src, edge.dest]
        end
      end
      short_path
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

graph.add_edge(src: 'A', dest: 'B', weight: 28)
graph.add_edge(src: 'A', dest: 'F', weight: 10)
graph.add_edge(src: 'B', dest: 'G', weight: 14)
graph.add_edge(src: 'B', dest: 'C', weight: 16)
graph.add_edge(src: 'F', dest: 'E', weight: 25)
graph.add_edge(src: 'D', dest: 'E', weight: 22)
graph.add_edge(src: 'G', dest: 'E', weight: 24)
graph.add_edge(src: 'G', dest: 'D', weight: 18)
graph.add_edge(src: 'C', dest: 'D', weight: 12)

kruskal = Graph::MstKruskal.new(graph: graph)
print kruskal.mst
