print('pairjumper')

local vim = vim

local M = {}

local ps = {
    '.', ',', ';',
    ['('] = ')',
    ['['] = ']',
    ['{'] = '}',
    ['<'] = '>',
    ['\''] = '\'',
    ['"'] = '"',
    ['`'] = '`',
}

M.is_pairs = function()
    for k, v in pairs(ps) do
        print(k .. ':' .. v)
    end
end

print(M.is_pairs())

return M
