; 言語を日本語にする
(set-language-environment 'Japanese)
; UTF-8とする
(prefer-coding-system 'utf-8)

; 起動時の画面はいらない
(setq inhibit-startup-message t)

;;; 補完時に大文字小文字を区別しない
(setq completion-ignore-case t)

;; load-path の追加
(setq load-path (append
                 '("~/.emacs.d"
  	   "~/.emacs.d/packages")
                 load-path))



;;global setup
(display-time-mode 1)
;;display time in modeline
(setq inhibit-startup-message t)
;;inhibits the startup screen
(setq initial-scratch-message nil)
;;do not show starting message
(setq line-number-mode t)
;;show line number
(setq column-number-mode t)
;;show coloumn number

;; エラー音をならなくする
(setq ring-bell-function 'ignore)

;;背景・文字など
(custom-set-faces
 '(default ((t
             (:background "#A9A9A9" :foreground "#310000")
             )))
 '(cursor ((((class color)
             (background dark))
            (:background "#00AA00"))
           (((class color)
             (background light))
            (:background "#282828"))
           (t ())
           )))


;;key setting
(global-set-key "\C-h" 'backward-delete-char)           ;; 1字前を消去
(global-set-key "\C-x\C-x" 'comment-region)             ;; コメントアウト
(global-set-key "\C-xt" 'uncomment-region)              ;; コメントアウトアウト
(global-set-key "\C-cr" 'replace-string)                ;; 文字列置換
(global-set-key "\C-ci" 'indent-region)                 ;; インデント
(global-set-key "\C-cq" 'query-replace)                 ;; クエリ置換
(global-set-key "\C-xp" 'goto-line)                     ;; 指定行へジャンプ
(global-set-key "\C-cf" 'set-buffer-file-coding-system) ;; 文字コードの変更
(global-set-key "\M-?"  'help-for-help)                 ;; ヘルプ

;;
(global-set-key "\C-z"  'undo)                          ;; Undo

;;¥ª¡¼¥È¥¤¥ó¥Ç¥ó¥È
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key "\C-j" 'newline)

;;カーソルの点滅を止める
(blink-cursor-mode 0)

;;; 対応する括弧を光らせる。
(show-paren-mode 1)
(setq show-paren-delay 0.1)
(setq show-paren-style 'expression)
(set-face-attribute 'show-paren-match-face nil
                    :background "#0099c0" :foreground nil
                    :underline nil :weight 'extra-bold)
;;; ウィンドウ内に収まらないときだけ括弧内も光らせる。
(setq show-paren-style 'mixed)


;;ウィンドウの設定
(setq initial-frame-alist '((width . 75) (height . 30) (top . 22)(left . 0)))

;; フォントの変更
(if window-system (progn
                    (add-to-list 'default-frame-alist '(font . "SourceCodePro-Light-21:weight=bold"))
                    (set-fontset-font "fontset-default"
                                      'japanese-jisx0208
                                      '("ヒラギノ角ゴ Pro" . "iso10646-1"))
                    (set-fontset-font "fontset-default"
                                      'katakana-jisx0201
                                      '("ヒラギノ角ゴ Pro" . "iso10646-1"))
                    (setq face-font-rescale-alist
                          '(
                            (".*ヒラギノ角ゴ Pro.*"    . 1.2)
                            ))
                    )
  )

;; マウスで選択するとコピーする Emacs 24 ではデフォルトが nil
(setq mouse-drag-copy-region t)




;; パッケージの追加
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-x b でバッファの内容を表示しながら、バッファを切り替える
;; C-s,C-rで補完候補を選択
(iswitchb-mode 1)

(defadvice iswitchb-exhibit
  (after
   iswitchb-exhibit-with-display-buffer
   activate)
  "選択している buffer を window に表示してみる。"
  (when (and
         (eq iswitchb-method iswitchb-default-method)
         iswitchb-matches)
    (select-window
     (get-buffer-window (cadr (buffer-list))))
    (let ((iswitchb-method 'samewindow))
      (iswitchb-visit-buffer
       (get-buffer (car iswitchb-matches))))
    (select-window (minibuffer-window))))


;;YaTeX の設定適用
(setq auto-mode-alist
(cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
;; YaTeX のパスを通す(app 名は適宜変更)
(setq load-path (cons "~/.emacs.d/packeges/yatex1.77" load-path))
;; プレビュー(TeXShop の使用)
(setq tex-command
"~/Library/TeXShop/bin/platex2pdf-utf8" dvi2-command "open -a TexShop")
