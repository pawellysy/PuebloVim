return {
    'rust-lang/rust.vim',
    ft = {'rust'},
    init = function ()
        vim.g.rustfmt_autosave = 1
        vim.g.rustfmt_fail_silently = 1
        vim.g.rustfmt_emit_files = 1
        vim.g.rustfmt_options = {
            ['merge_imports'] = true,
            ['format_code_in_doc_comments'] = true,
            ['normalize_doc_attributes'] = true,
            ['normalize_comments'] = true,
            ['reorder_imports'] = true,
            ['reorder_modules'] = true,
            ['space_after_colon'] = true,
            ['space_before_colon'] = false,
            ['space_between_empty_braces'] = false,
            ['spaces_around_ranges'] = true,
            ['spaces_within_parens'] = false,
            ['use_small_heuristics'] = true,
            ['wrap_comments'] = true,
            ['wrap_attributes'] = true,
            ['tab_spaces'] = 4,
            ['max_width'] = 100,
        }
    end

}
