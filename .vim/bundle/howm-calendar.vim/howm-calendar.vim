scriptencoding cp932

if exists('enable_QFixHowmCalendar') && !enable_QFixHowmCalendar
  finish
endif
if exists('disable_QFixWin') && disable_QFixWin
  finish
endif
if exists('disable_MyHowm') && disable_MyHowm
  finish
endif
if exists("loaded_QFixCalendar_vim") && !exists('fudist')
  finish
endif
let loaded_QFixCalendar_vim = 1
if v:version < 700 || &cp
  finish
endif

if !exists('calendar_action')
  let calendar_action = "QFixHowmCalendarDiary"
endif
if !exists('calendar_sign')
  let calendar_sign   = "QFixHowmCalendarSign"
endif

let s:calendar_DiaryFile = '%Y/%m/%Y-%m-%d-000000.howm'

function! QFixHowmCalendarSign(day, month, year)
  if !exists('g:QFixHowm_DiaryFile')
    let g:QFixHowm_DiaryFile = s:calendar_DiaryFile
  endif

  let year  = printf("%4.4d",a:year)
  let month = printf("%2.2d",a:month)
  let day   = printf("%2.2d",a:day)
  let sfile = g:QFixHowm_DiaryFile
  let sfile = substitute(sfile, '%Y', year, 'g')
  let sfile = substitute(sfile, '%m', month, 'g')
  let sfile = substitute(sfile, '%d', day, 'g')
  let sfile = g:howm_dir.'/'.sfile
  return filereadable(sfile)
endfunction

function! QFixHowmCalendarDiary(day, month, year, week, dir)
  if !exists('g:QFixHowm_DiaryFile')
    let g:QFixHowm_DiaryFile = s:calendar_DiaryFile
  endif
  let year  = printf("%4.4d",a:year)
  let month = printf("%2.2d",a:month)
  let day   = printf("%2.2d",a:day)
  let hfile = g:QFixHowm_DiaryFile
  let hfile = substitute(hfile, '%Y', year, 'g')
  let hfile = substitute(hfile, '%m', month, 'g')
  let hfile = substitute(hfile, '%d', day, 'g')
  let sfile = g:howm_dir.'/'.hfile
  let winnr = bufwinnr(bufnr(sfile))
  let lwinnr = winnr('$')
  set winfixwidth
  wincmd w
  if filereadable(sfile)
    if winnr > -1
      exec winnr.'wincmd w'
    else
      exe "e " . escape(sfile, ' ')
    endif
  else
    call QFixHowmCreateNewFile(hfile)
  endif
  if lwinnr == 1
    Calendar
    wincmd p
  endif
endfunction

