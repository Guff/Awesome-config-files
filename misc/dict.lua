words = {}

for word in io.lines("/home/kevin/.dictcache") do
	table.insert(words, word)
end

function dict_cb(text, cur_pos, ncomp)
	return awful.completion.generic(text, cur_pos, ncomp, words)
end
