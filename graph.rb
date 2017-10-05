class Graph
  attr_accessor :edge_node, :graph, :visited
  def initialize(vertexes, edges)
    @edge_node = Struct.new(:adj_vex, :weight, :next)
    @vertex_node = Struct.new(:data, :first_edge)
    @vertexes = vertexes
    @edges = edges
    @graph = []

    create_graph

    @visited = []
  end

  def init
    @vertexes.times do |i|
      @visited[i] = false
    end
  end

  def create_graph
    for i in 0...@vertexes
      puts "input vertex"
      @graph << @vertex_node.new(gets.chomp, nil)
    end

    for j in 0...@edges
      puts "input edge(vi, vj)"
      i = gets.chomp.to_i - 1
      j = gets.chomp.to_i - 1

      edge_node = @edge_node.new(j, nil, @graph[i].first_edge)
      @graph[i].first_edge = edge_node

      edge_node = @edge_node.new(i, nil, @graph[j].first_edge)
      @graph[j].first_edge = edge_node
    end
  end

  def dfs(i)
    if !@visited[i]
      @visited[i] = true
      print @graph[i].data

      edge = @graph[i].first_edge

      loop do
        break if edge.nil?
        dfs(edge.adj_vex) unless @visited[edge.adj_vex]
        edge = edge.next
      end
    end
  end

  def bfs(i)
    queue = []

    if !visited[i]
      visited[i] = true
      print @graph[i].data

      queue << i

      loop do
        break if queue.empty?

        i = queue.shift
        edge = @graph[i].first_edge

        loop do
          break if edge.nil?
          if !visited[edge.adj_vex]
            visited[edge.adj_vex] = true
            print @graph[edge.adj_vex].data
            queue << edge.adj_vex
          end
          edge = edge.next
        end
      end
    end
  end
end


g= Graph.new(4,4)
# for i in 0...4
  g.dfs 0
# p g.visited
# g.bfs 0
# end
