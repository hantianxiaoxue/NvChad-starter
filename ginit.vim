let s:fontsize = 13
set guifont=JetBrainsMono\ NFM:h13
function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
  :execute "set guifont=JetBrainsMono\\ NFM:h" . s:fontsize
endfunction


function! ToggleTransparency()
  let g:neovide_transparency = g:neovide_transparency==1 ? 0.85 : 1
endfunction
noremap <C-t> :call ToggleTransparency()<CR>

noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a


let g:neovide_cursor_trail_size = 0.0
let g:neovide_cursor_animation_length = 0.00
let g:neovide_remember_window_size = v:true
let g:neovide_fullscreen = v:true
let g:neovide_confirm_quit = v:false
let g:neovide_transparency = 1

let g:neovide_floating_blur_amount_x = 0.0
let g:neovide_floating_blur_amount_y = 0.0

let g:neovide_padding_top = 30
let g:neovide_padding_bottom = 0
let g:neovide_padding_right = 0
let g:neovide_padding_left = 0

augroup ime_input
    autocmd!
    autocmd InsertLeave * execute "let g:neovide_input_ime=v:false"
    autocmd InsertEnter * execute "let g:neovide_input_ime=v:true"
    autocmd CmdlineEnter [/\?] execute "let g:neovide_input_ime=v:false"
    autocmd CmdlineLeave [/\?] execute "let g:neovide_input_ime=v:true"
augroup END

