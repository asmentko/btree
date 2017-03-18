Node = Struct.new(:key, :left, :right)

class BTreeSort
  attr_accessor :trunk, :sorted_array

  def initialize(key = nil, sorted_array = [])
    @trunk = Node.new(key)
    @sorted_array = sorted_array
  end

  def self.sort(array)
    # to get the tree built, I need to send init_array to add_to_tree
    # before I call the sorted array, I need the tree to be created so I 
    #    can send the trunk to traverse_tree
    # I need to have the sorted array returned to me
    new_tree = build_tree(array)
    traverse_tree(new_tree.trunk)
  end

  # method to convert array element to payload, children default to nil
  def self.build_tree(array)
    tree = BTreeSort.new
    array.each do |key|
      tree.insert(key)
    end
    return tree
  end


  # method to add nodes
  def insert(key)
    @trunk = Node.new(key) if @trunk.key == nil
    current_node = @trunk
    while current_node != nil
      if (key < current_node.key) && (current_node.left == nil)
      current_node.left = Node.new(key)
      elsif (key > current_node.key) && (current_node.right == nil)
      current_node.right = Node.new(key)
      elsif (key < current_node.key)
      current_node = current_node.left
      elsif (key > current_node.key)
      current_node = current_node.right
      else 
        return
      end
    end
  end

  # method to flatten tree and move to final sorted array
  def self.traverse_tree(node = @trunk)
    return @sorted_array if (node == nil)
    traverse_tree(node.left)
    @sorted_array << node.left
    traverse_tree(node.right)
  end

end