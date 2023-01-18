local lsp_signature = require('lsp_signature')

lsp_signature.setup({
    hint_enable = true,
    hint_prefix = " ",
    toggle_key = '<M-x>',
    select_signature_key = '<M-n>'
})
