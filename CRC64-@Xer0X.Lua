--[[	@Xer0X CopyLeft 2019
	Православие или Смерть! Group
	..
	This script is simplified implementation
	of common CRC64 algorithm.
]]

if not _G.Xer0X then _G.Xer0X = {} end

local crc64

crc64 = {
	new = function(self, str_init)
		local tbl_new = {
			fnc_append = self.fnc_append,
			fnc_result = self.fnc_result
		}
		if str_init 
		then crc64.fnc_append(tbl_new, str_init)
		end
		return tbl_new, crc64.fnc_result(tbl_new)
	end;
}

crc64.fnc_append = function(self, str,
	c1, c2, c3, c4,
	c5, c6, c7, c8
		)
	if not self then self = crc64:new() end
	c1, c2, c3, c4,
	c5, c6, c7, c8 =
		c1 or self._c1 or 0, c2 or self._c2 or 0, c3 or self._c3 or 0, c4 or self._c4 or 0,
		c5 or self._c5 or 0, c6 or self._c6 or 0, c7 or self._c7 or 0, c8 or self._c8 or 0
	local pos,
		b1, b2, b3, b4,
		b5, b6, b7, b8
	local str_size = string.len(str) / 8 - 1
	for	ii = 0, str_size
	do	pos = ii * 8 + 1
		b1, b2, b3, b4,
		b5, b6, b7, b8 =
			string.byte(str, pos, pos + 8)
		c1, c2, c3, c4,
		c5, c6, c7, c8 =
			bxor(c1, b1), bxor(c2, b2), bxor(c3, b3), bxor(c4, b4),
			bxor(c5, b5), bxor(c6, b6), bxor(c7, b7), bxor(c8, b8)
	end
	pos = (str_size + 1) * 8
	b1, b2, b3, b4,
	b5, b6, b7, b8 =
		nil, nil, nil, nil,
		nil, nil, nil, nil
	b1, b2, b3, b4,
	b5, b6, b7, b8 =
		string.byte(str, pos, pos + 8)
	c1, c2, c3, c4,
	c5, c6, c7, c8 =
		bxor(c1, b1 or 0), bxor(c2, b2 or 0), bxor(c3, b3 or 0), bxor(c4, b4 or 0),
		bxor(c5, b5 or 0), bxor(c6, b6 or 0), bxor(c7, b7 or 0), bxor(c8, b8 or 0)
	self._c1, self._c2, self._c3, self._c4,
	self._c5, self._c6, self._c7, self._c8 =
		c1, c2, c3, c4,
		c5, c6, c7, c8
	return c1, c2, c3, c4, c5, c6, c7, c8
end

crc64.fnc_result = function(self)
	if not self._c1 then return end	 
	self._crc64_int =
		self._c1 +
		self._c2 * (256) +
		self._c3 * (256 * 256) +
		self._c4 * (256 * 256 * 256) +
		self._c5 * (256 * 256 * 256 * 256) +
		self._c6 * (256 * 256 * 256 * 256 * 256) +
		self._c7 * (256 * 256 * 256 * 256 * 256 * 256) +
		self._c8 * (256 * 256 * 256 * 256 * 256 * 256 * 256)
	self._crc64_str = string.format("%02X", self._crc64_int)
	return self._crc64_int, self._crc64_str,
		self._c1, self._c2, self._c3, self._c4,
		self._c5, self._c6, self._c7, self._c8
end


return crc64;

