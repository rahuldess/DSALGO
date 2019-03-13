module DisjointSet

  ####### Tip ####################
  # 0. Think of "Common Elements" finding with this disjoint sets.
  # 1. Create Node for each set value
  # 2. For Union Function
  #      A. Increase any of root's Rank value by 1 if rank(root(A)) == rank(root(B))
  #      B. Point root(B).parent --> root(A) If rank(root(A)) > rank(root(B)) 
  #      C. Point root(A).parent --> root(B) If rank(root(A)) < rank(root(B)) 
  # 3. Return root value of node for find_set method.
  
  class Node
    attr_accessor :data, :parent, :rank

    def initialize(data:, parent: nil, rank: 0)
      @data   = data
      @parent = parent
      @rank   = rank
    end
  end

  ################################

  class DisjointSet
    attr_accessor :total_sets

    def initialize
      @total_sets = {}
    end

    def union(node_x:, node_y:)
      return if !total_sets.key?(node_x) || !total_sets.key?(node_y)

      root_of_x = find_root(total_sets[node_x])
      root_of_y = find_root(total_sets[node_y])

      if root_of_x.rank == root_of_y.rank
        root_of_y.parent = root_of_x
        root_of_x.rank += 1
      elsif root_of_x.rank > root_of_y.rank
        root_of_y.parent = root_of_x
      elsif root_of_y.rank > root_of_x.rank
        root_of_x.parent = root_of_y
      end
      total_sets
    end

    def make_set(value:)
      total_sets[value] = Node.new(data: value) 
      total_sets
    end

    def find_set(value:)
      node = total_sets[value]
      return if node.nil?
      return node.data if node.parent.nil?

      find_set(value: node.parent.data)
    end

    private

    def find_root(node)
      return node if node.parent.nil?
      find_root(node.parent)
    end
  end
end


#disjoint_set = DisjointSet.new
#disjoint_set.make_set(value: 1)
#disjoint_set.make_set(value: 2)
#disjoint_set.make_set(value: 3)
#disjoint_set.make_set(value: 4)
#disjoint_set.make_set(value: 5)
#disjoint_set.make_set(value: 6)
#disjoint_set.make_set(value: 7)
#
#disjoint_set.union(node_x: 1, node_y: 2)
#disjoint_set.union(node_x: 2, node_y: 3)
#disjoint_set.union(node_x: 4, node_y: 5)
#disjoint_set.union(node_x: 6, node_y: 7)
#disjoint_set.union(node_x: 5, node_y: 6)
#disjoint_set.union(node_x: 3, node_y: 7)
#
#print disjoint_set.find_set(value: 5)
