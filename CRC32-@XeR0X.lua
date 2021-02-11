--[[	@Xer0X CopyLeft 2019
	Православие или Смерть! Group
	White Power Resistance Commando@line team
	..
	Presenting to you!

	This script is simplified implementation
	of common CRC32 algorithm.
]]

if not _G.Xer0X then _G.Xer0X = {} end

function Xer0X.fnc_crc32(self, str, c1, c2, c3, c4)
	local c1, c2, c3, c4 = c1 or self._c1 or 0, c2 or self._c2 or 0, c3 or self._c3 or 0, c4 or self._c4 or 0
	local b1, b2, b3, b4, pos
	local str_size = string.len(str) / 4 - 1
	for	ii = 0, str_size 
	do	pos = ii * 4 + 1
		b1, b2, b3, b4 = string.byte(str, pos, pos + 4)
		c1, c2, c3, c4 = bxor(c1, b1), bxor(c2, b2), bxor(c3, b3), bxor(c4, b4)
	end
	pos = (str_size + 1) * 4
	b1, b2, b3, b4 = nil, nil, nil, nil
	b1, b2, b3, b4 = string.byte(str, pos, pos + 4)
	c1, c2, c3, c4 = bxor(c1, b1 or 0), bxor(c2, b2 or 0), bxor(c3, b3 or 0), bxor(c4, b4 or 0)
	self._c1, self._c2, self._c3, self._c4 = c1, c2, c3, c4
	self._crc32_int = c1 + c2 * (256) + c3 * (256 * 256) + c4 * (256 * 256 * 256)
	self._crc32_str = string.format("%02X%02X%02X%02X", c4, c3, c2, c1)
	return self._crc32_int, self._crc32_str, c1, c2, c3, c4
end

local crc32 = {
	fnc_append_crc32 = Xer0X.fnc_crc32;
	new = function(self)
		return { fnc_append_crc32 = self.fnc_append_crc32 }
	end;
}

return crc32;

