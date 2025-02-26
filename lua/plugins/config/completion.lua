local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
    completion = {
        max_items_count = 15,
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.confirm({ select = true })
            elseif vim.fn["copilot#Accept"]() == 1 then
                -- If Copilot suggestion is present, accept it
                vim.fn["copilot#Accept('<CR>')"]()
            else
                fallback() -- Fall back to normal <CR> behavior
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "copilot" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
    }),
})
