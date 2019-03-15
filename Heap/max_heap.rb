require_relative '../util_library'

####### Tip ####################
# 1. Heap is nothing but an array representation.
# 2. left_child = (2*i + 1), right_child = (2*i + 2), parent = (i-1/2)
# 3. Insert into array --> Follow with 'heapify' ( To correct the heap order format )
# 4. FindMax --> Delete root element --> Perlocate down ( To correct the heap structure format )
################################

module Heap
  class MaxHeap
    attr_accessor :heap
    attr_reader :root

    def initialize
      @heap = []
      @root = 0
    end

    def insert(value:)
      heap.push(value)
      heapify if heap.size > 1
    end

    def find_max
      return if heap.empty?
      max = heap[root]
      # replacing last most child with root
      heap[root] = heap[heap.size - 1]
      heap.delete_at(heap.size - 1)
      # Re-order heap again a.k.a bubble down
      perlocate_down
      return max
    end

    private 

    def perlocate_down
      parent = root
      max_child = max(left_child: ((2 * parent) + 1), right_child: ((2 * parent) + 2) )

      while max_child != -1 && heap[parent] < heap[max_child]
        if heap[parent] < heap[max_child]
          temp = heap[max_child]
          heap[max_child] = heap[parent]
          heap[parent] = temp
        end
        parent = max_child
        max_child = max(left_child: ((2 * parent) + 1), right_child: ((2 * parent) + 2))
      end
    end

    def max(left_child:, right_child:)
      if left_child < heap.size  && right_child >= heap.size
        left_child
      elsif left_child >= heap.size  && right_child < heap.size
        right_child
      elsif left_child < heap.size  && right_child < heap.size
        heap[left_child] > heap[right_child] ? left_child : right_child
      elsif left_child >= heap.size && right_child >= heap.size
        -1
      end
    end

    def heapify
      current = heap.size - 1
      parent  = (current - 1) / 2

      while current > 0 || heap[current] < heap[parent] do
        if heap[current] > heap[parent]
          temp = heap[parent]
          heap[parent] = heap[current]
          heap[current] = temp
        end
        current = parent
        parent  = (current - 1) / 2
      end
    end
  end
end

#max_heap = Heap::MaxHeap.new()
#max_heap.insert(value: 2)
#max_heap.insert(value: 10)
#max_heap.insert(value: 15)
#max_heap.insert(value: 4)
#max_heap.insert(value: 100)
#max_heap.insert(value: 1)
#max_heap.insert(value: 200)
#max_heap.insert(value: 100)
#
#puts max_heap.find_max
#puts max_heap.find_max
#puts max_heap.find_max
#puts max_heap.find_max
#puts max_heap.find_max
#puts max_heap.find_max
#puts max_heap.find_max
#puts max_heap.find_max

