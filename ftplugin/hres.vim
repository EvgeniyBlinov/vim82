setlocal foldmethod=expr
setlocal foldexpr=GetHresFold(v:lnum)
setlocal foldtext=HresFoldText()

function! GetHresFold(lnum)
    " 1. Главный заголовок (Уровень 1)
    if getline(a:lnum) =~# '^\/\*\*.\+\*\*\/$'
        return '>1'
    endif

    " 2. Вложенный заголовок с дефисами (Уровень 2)
    " Проверяем, что текущая строка — дефисы, а следующая — текст (не пустая и не дефисы)
    if getline(a:lnum) =~# '^-\{3,\}$' && getline(a:lnum + 1) =~# '\S' && getline(a:lnum + 1) !~# '^-\{3,\}$'
        return '>2'
    endif

    " Все остальные строки сохраняют текущий уровень фолдинга
    return '='
endfunction

function! HresFoldText()
    let l:start_line = getline(v:foldstart)
    let l:title = ''
    let l:first_content_lnum = v:foldstart + 1

    " Определяем заголовок в зависимости от уровня фолда
    if v:foldlevel == 1
        " Для уровня 1 чистим звездочки
        let l:title = substitute(l:start_line, '^[/* \t]\+\|[/* \t]\+$', '', 'g')
    else
        " Для уровня 2 имя берем со следующей строки после дефисов
        let l:title = substitute(getline(v:foldstart + 1), '^[ \t]\+\|[ \t]\+$', '', 'g')
        let l:first_content_lnum = v:foldstart + 2
    endif

    " Ищем первую полезную строку для вывода после разделителя |
    let l:next_line = ''
    let l:current = l:first_content_lnum

    while l:current <= v:foldend
        let l:line = getline(l:current)
        " Игнорируем пустоту, решетки, дефисы и саму строку заголовка
        if l:line =~# '\S' && l:line !~# '^#\+$' && l:line !~# '^-\{3,\}$' && l:line !=# l:title
            " Если внутри уровня 1 встретился вложенный блок (дефисы),
            " берем его заголовок как контент для превью главного блока
            if v:foldlevel == 1 && l:line =~# '^-\{3,\}$' && getline(l:current + 1) =~# '\S'
                let l:next_line = substitute(getline(l:current + 1), '^[ \t]\+\|[ \t]\+$', '', 'g')
                break
            endif
            let l:next_line = substitute(l:line, '^[ \t]\+', '', '')
            break
        endif
        let l:current += 1
    endwhile

    if empty(l:next_line)
        return l:title . ' | (нет данных)'
    endif

    return l:title . ' | ' . l:next_line
endfunction
