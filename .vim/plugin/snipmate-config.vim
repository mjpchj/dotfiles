if v:version >= 700

    let snips_author = 'Matt Chapman Jones'

    if !exists('g:snipMate')
      let g:snipMate = {}
    endif

    let g:snipMate['scope_aliases'] = {
        \   'cpp':      'c',
        \   'cs':       'c',
        \   'eco':      'html',
        \   'eruby':    'html',
        \   'html':     'htmlonly',
        \   'less':     'css',
        \   'mxml':     'actionscript',
        \   'objc':     'c',
        \   'php':      'html',
        \   'scss':     'css',
        \   'smarty':   'html',
        \   'ur':       'html',
        \   'xhtml':    'htmlonly,html',
        \}

endif
