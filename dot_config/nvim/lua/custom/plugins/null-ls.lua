local present, null_ls = pcall(require, "null-ls")
if not present then
  return
end

local b = null_ls.builtins

local sources = {
  b.code_actions.gitsigns,
  b.code_actions.eslint_d,

  b.diagnostics.eslint_d,
  b.diagnostics.fish,

  b.formatting.eslint_d,
  b.formatting.prettierd,
  b.formatting.gofmt,
  b.formatting.fish_indent
}
