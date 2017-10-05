
class BinaryTree
  attr_reader :root, :tree_node
  attr_writer :root
  def initialize
    @tree_node = Struct.new(:left, :right, :data)
    @root = nil
  end

  def create(list)
    fail unless list.is_a? Array

    return if list.empty?

    tree_nodes = []
    list.each do |item|
      tree_nodes << @tree_node.new(nil, nil, item)
    end

    tree_nodes.each_with_index do |node, index|
      left_node = tree_nodes[(index + 1) * 2 - 1] rescue nil
      right_node = tree_nodes[(index + 1) * 2] rescue nil

      node.left = left_node
      node.right = right_node
    end

    @root = tree_nodes.first
  end

  def pre_order_traverse(node = @root)
    return if node.nil?
    print node.data
    pre_order_traverse(node.left)
    pre_order_traverse(node.right)
  end

  def in_order_traverse(node = @root)
    return if node.nil?
    in_order_traverse(node.left)
    print node.data
    in_order_traverse(node.right)
  end

  def post_order_traverse(node = @root)
    return if node.nil?
    post_order_traverse(node.left)
    post_order_traverse(node.right)
    print node.data
  end

  def level_order_traverse
    queue = []
    queue << @root

    loop do
      break if queue.empty?
      node = queue.shift
      print node.data
      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
    end
  end
end
