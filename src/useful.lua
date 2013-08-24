useful = {}

function useful.tri(cond,yes,no)
	if cond then
		return yes
	else
		return no
	end
end

function useful.clone(cloneMe)
	if cloneMe then
		if type(cloneMe)=="table" then
			local cln = {}
			for k,v in pairs(cloneMe) do
				cln[k] = useful.clone(v)
			end
			return cln
		else
			return cloneMe
		end
	end
end

function useful.lerp(p1, p2, n)
	n = math.max(0,math.min(1, n))
	return p1*(1-n)+p2*n
end