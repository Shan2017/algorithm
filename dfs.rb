def dfs(step)
	if step == (@n + 1)
		@boxes.each { |box| print box; print "\t" }
		puts
		return
	end

	for i in 1..@n
		if @book[i] == 0
			@boxes[step] = i
			@book[i] = 1
			dfs(step + 1)
			@book[i] = 0
		end
	end
end

@n = 3
@boxes = Array.new(@n + 1, 0)
@book = Array.new(@n + 1, 0)
dfs(1)
