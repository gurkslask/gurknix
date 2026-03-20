local dap = require("dap")
local dapui = require("dapui")
local wk = require("which-key")
local dap_go = require('dap-go')
local dap_python = require('dap-python')

dapui.setup({})

-- wk.register({
	-- d = {
		-- name = "DAP",
		-- g = { dapui.toggle, "Toggle DAP UI" },
		-- b = { dap.toggle_breakpoint, "Toggle breakpoint" },
		-- B = {
			-- function()
				-- dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			-- end,
			-- "Set conditional breakpoint",
		-- },
		-- r = { dap.repl.toggle, "Toggle REPL" },
		-- c = { dap.continue, "Start/Continue debugging" },
		-- p = { dap.pause, "Pause" },
		-- t = { dap.terminate, "Terminate" },
		-- n = { dap.run_to_cursor, "Run to cursor" },
		-- e = { dap.step_over, "Step over" },
		-- i = { dap.step_into, "Step into" },
		-- o = { dap.step_out, "Step out" },
		-- u = { dap.up, "Go up the stack" },
		-- d = { dap.down, "Go down the stack" },
		-- T = {
			-- name = "Tests",
			-- p = {dap_python.test_method, "Python"},
			-- g = {dap_go.debug_test, "Golang"},
		-- },
	-- },
-- }, { prefix = "<leader>" })
wk.add({
  -- Huvudgrupp för DAP
  { "<leader>d", group = "DAP" },
  { "<leader>dg", dapui.toggle, desc = "Toggle DAP UI" },
  { "<leader>db", dap.toggle_breakpoint, desc = "Toggle breakpoint" },
  { "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Set conditional breakpoint" },
  { "<leader>dr", dap.repl.toggle, desc = "Toggle REPL" },
  { "<leader>dc", dap.continue, desc = "Start/Continue debugging" },
  { "<leader>dp", dap.pause, desc = "Pause" },
  { "<leader>dt", dap.terminate, desc = "Terminate" },
  { "<leader>dn", dap.run_to_cursor, desc = "Run to cursor" },
  { "<leader>de", dap.step_over, desc = "Step over" },
  { "<leader>di", dap.step_into, desc = "Step into" },
  { "<leader>do", dap.step_out, desc = "Step out" },
  { "<leader>du", dap.up, desc = "Go up the stack" },
  { "<leader>dd", dap.down, desc = "Go down the stack" },

  -- Undergrupp för Tester
  { "<leader>dT", group = "Tests" },
  { "<leader>dTp", function() dap_python.test_method() end, desc = "Python Test" },
  { "<leader>dTg", function() dap_go.debug_test() end, desc = "Golang Test" },
})

dap_go.setup()
dap_python.setup("python")
dap_python.test_runner = "pytest"
