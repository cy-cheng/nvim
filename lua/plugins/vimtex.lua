return {
    {
        "lervag/vimtex",
        config = function()
            vim.g.vimtex_compiler_method = 'latexmk'
            vim.g.vimtex_compiler_latexmk = {
                continuous = 1,  -- Enable continuous compilation
                options = {
                  "-xelatex",  -- Use xelatex for Chinese support
                  "-interaction=nonstopmode",  -- Ignore errors and continue compilation
                },
            } 
        end
    }
}
