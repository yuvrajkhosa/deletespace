local M = {}

function M.setup()

  vim.keymap.set("n", "<Leader>ds", function()

    local space_lines = {}

    local line_count = vim.api.nvim_buf_line_count(0)
    local lines = vim.api.nvim_buf_get_lines(0, 0, line_count, true)

    for line_number, line in ipairs(lines) do
      local is_last_space = string.byte(line, -1) == 32
      if is_last_space then
        local first_non_space = string.len(line)
        while first_non_space > 1 and string.byte(line, first_non_space - 1) == 32 do
          first_non_space = first_non_space - 1
        end
        space_lines[line_number] = string.sub(line, 1, first_non_space - 1)
      end
    end

    for line_number, line in pairs(space_lines) do
      vim.api.nvim_buf_set_lines(0, line_number - 1, line_number, true, {line})
      print(line_number)
    end
  end)
end


return M
