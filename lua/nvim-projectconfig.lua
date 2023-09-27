local M = {}
local project_dir = vim.fn.stdpath('config') .. '/projects/'

local function execute(file_path)
    file_path = vim.fn.expand(file_path)
    if vim.fn.filereadable(file_path) == 1 then
        vim.cmd('source ' .. file_path)
        return true
    end
    return false
end

local function get_config_by_ext(ext)
    local rootFolder = string.match(vim.fn.getcwd(), '[^%/]+$')
    return project_dir .. rootFolder .. '.' .. ext
end

function M.load_config()
    project_dir = vim.fn.expand(project_dir)
    if vim.fn.isdirectory(project_dir) == 0 then
        vim.fn.mkdir(project_dir)
    end
    if execute(get_config_by_ext('lua')) then
        return true
    end
    if execute(get_config_by_ext('vim')) then
        return true
    end
    return false
end

return M
