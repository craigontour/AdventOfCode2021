# From: https://medium.com/codex/data-structures-algorithms-in-ruby-breadth-first-search-for-binary-trees-6bcbb48bd88b
# But....it doesn't create the tree structure.
# Not sure how this works
# Need to read earlier articles.

class Node
  attr_accessor :value, :left, :right

  def initialize(value)
      @value = value
      @left = nil
      @right = nil
  end
end

class BinarySearchTree
  attr_accessor :root

  def initialize
      @root = nil
  end

  def insert(value)
      new_node = Node.new(value)
      if !root
          @root = new_node
          return self
      end
      current = @root
      while current do
          return nil if current.value == value
          if value > current.value
              if !current.right
                  current.right = new_node
                  break
              else 
                  current = current.right
              end
          else 
              if !current.left
                  current.left = new_node
                  break
              else 
                  current = current.left
              end
          end
      end
      return self
  end
end

bst = BinarySearchTree.new

tree = [7,2,6,3,4,2,5]
tree.each do |v|
  bst.insert(v)
end
pp bst

def breadth_first_search
  queue = []
  result = []
  queue.push(@root)
  while queue.length != 0 do
      current = queue.shift()
      result.push(current)
      queue.push(current.left) if !!current.left
      queue.push(current.right) if !!current.right
  end
  return result
end

breadth_first_search
