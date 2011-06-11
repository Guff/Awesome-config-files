words = {}

for word in io.lines(awful.util.getdir("cache") .. "/dictcache") do
	table.insert(words, word)
end

function dict_cb(text, cur_pos, ncomp)
	return awful.completion.generic(text, cur_pos, ncomp, words)
end
