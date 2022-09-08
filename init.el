;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; INITIALIZATION
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "==== Initial Bootstrap ====")
;;
;; FILE LOCATIONS
;; Emacs Customization File
(setq custom-file (concat user-emacs-directory "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))
;; Temporary Directory
(setq temporary-file-directory "c:/temp/")
;;
;; Setting up package archives
;;
(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")))
(setq package-archive-priorities
      '(("melpa" . 9)
        ("org" . 10)
        ("gnu" . 5)))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
;;
;; Setup use-package
;;
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  (eval-when-compile (require 'use-package)))
(setq use-package-always-ensure t)
;;
;; Benchmarking package loading
;;
(use-package benchmark-init
  :config
  (add-hook 'after-init-hook 'benchmark-init/deactivate))
(add-hook 'after-init-hook (lambda () (message "loaded in %s" (emacs-init-time))))
;;
;; Increasing the garbage collection threshold
;; The default garbage collection threshold is 800 kB, and increasing
;; this to 10 MB for startup increases the speed.
;;
(setq gc-cons-threshold 10000000)
;;
;; Restore the original garbage collection after startup.
;;
(add-hook 'after-init-hook
	  (lambda ()
	    (setq gc-cons-threshold 1000000)
	    (message "gc-cons-threshold restored to %S"
		         gc-cons-threshold)))
;;
;; Hotkey for configuration file
;;
(defun find-config ()
  "Edit init.el"
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "C-c I") 'find-config)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; GENERAL SETTINGS
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Some sane default settings
;;
(message "==== Applying general settings ====")
(setq-default
 inhibit-startup-screen t               ;; Just go directly to initial buffer
 column-number-mode t                   ;; Shows row and column on the modeline
 delete-by-moving-to-trash t            ;; Deletes files to OS trash
 indent-tabs-mode nil                   ;; Tab inserts spaces instead of tabs
 display-time-day-and-date t            ;; For display-time-mode, also show the day.
 tab-width 4                            ;; Tab spacing defined to 4 spaces
 ring-bell-function 'ignore             ;; No bell
 use-short-answers t                    ;; Permit 'y' or 'n' instead of 'yes' or 'no'
 fill-column 80                         ;; Autowrap functions to column 80
 help-window-select t                   ;; I think this auto selects pop up windows.
 read-process-output-max (* 1024 1024)) ;; Increase read size for data chunks.

(put 'downcase-region 'disabled nil) ;; Eliminates irritating warning message
(put 'upcase-region 'disabled nil)   ;; Eliminates irritating warning message
;;
;; Revert buffers when the underlying file has changed
;;
(global-auto-revert-mode 1)
;;
;; Allows a number of commonly used and safe file variables.
;;
(put 'after-save-hook 'safe-local-variable
     (lambda (value) (equal value '(org-babel-tangle t))))
(put 'display-line-numbers-width 'safe-local-variable 'integerp)
;;
;; Unbind suspend-frame command
;;
(global-unset-key (kbd "C-x C-z"))
;;
;; Command History & Recent Files
;;
(savehist-mode 1)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(run-at-time nil (* 5 60) 'recentf-save-list)
;;
;; Personal Information Settings
;; This way I can have a identity for work and one for home and just
;; change that file by itself.
;;
(setq personal-info-file (concat user-emacs-directory "site-lisp/personal-info.el"))
(when (file-exists-p personal-info-file)
  (load personal-info-file))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; APPEARANCE
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Theme
;;
(message "==== Setting up client appearance ====")
(use-package all-the-icons
  :if (display-graphic-p))
(use-package vscode-dark-plus-theme
  :disabled
  :config
  (load-theme 'vscode-dark-plus t))
(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-hard))
;;
;; Font(s)
;;
;;(set-frame-font "Inconsolata 14" nil t)
(set-frame-font "Roboto Mono 12" nil t)
;;(set-frame-font "Consolas 14" nil t)
;;(set-frame-font "Cascadia Code 14" nil t)
;;(set-frame-font "Fira Code 13" nil t)
;;
;; Frame position and size
;;
(add-to-list 'default-frame-alist '(left . 150))
(add-to-list 'default-frame-alist '(top . 50))
(add-to-list 'default-frame-alist '(height . 35))
(add-to-list 'default-frame-alist '(width . 132))
;;
;; Transparency.  The first value in the cons cell is the alpha level of the
;; frame when focused (100 = fully opaque).  The second value in the cons cell
;; is the alpha level of the frame when not in focus.
;;
;; Leaving the setting here in case I change my mind, but currently I don't
;; like transparency on the editor all that much.
;;
(set-frame-parameter (selected-frame) 'alpha '(100 . 100))
;;
;; Client look and feel
;;
(global-visual-line-mode 1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(display-time-mode)
(show-paren-mode)
;;
;; Solaire lightens pop up windows
;;
(use-package solaire-mode
  :config
  (setq solaire-mode t))
;;
;; Line numbers
;;
(add-hook 'conf-mode-hook #'display-line-numbers-mode)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(add-hook 'text-mode-hook #'display-line-numbers-mode)
(add-hook 'vhdl-mode-hook #'display-line-numbers-mode)
(setq-default
 display-line-numbers-grow-only t
 display-line-numbers-type 'relative
 display-line-numbers-width 2)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; PACKAGES (Not loaded in other places)
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "==== Package Configuration ====")
;;
;; Rainbow Delimeters
;;
(message "---- Rainbow Delimiters")
(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'vhdl-mode-hook 'rainbow-delimiters-mode))
;;
;; Smartparens
;;
(message "---- Smartparens")
(use-package smartparens
  :hook
  (after-init . smartparens-global-mode)
  (wdired-mode . smartparens-mode)
  :custom
  (sp-highlight-pair-overlay nil)
  (sp-highlight-wrap-overlay nil)
  (sp-highlight-wrap-tag-overlay nil)
  :config
  (show-paren-mode 0)
  (require 'smartparens-config))
;;
;; Editing packages MoveText
;;
(message "---- MoveText")
(use-package move-text
  :config
  (move-text-default-bindings))
;;
;; Deadgrep -- ripgrep interface
;;
(message "---- Deadgrep")
(use-package deadgrep
  :config
  :bind (("<f5>" . #'deadgrep)))
;;
;; Multiple Cursors
;;
(message "---- Multiple Cursors")
(use-package multiple-cursors
  :ensure t
  :bind (("<C-M-down>" . mc/mark-next-like-this)
         ("<C-M-up>" . mc/mark-previous-like-this)
         ("C-M-<mouse-1>" . mc/add-cursor-on-click)))
;;
;; Company completion tools
;;
(message "---- Company")
(use-package company
  :config
  (global-company-mode t)
  (setq company-dabbrev-ignore-case 'keep-prefix)
  (setq company-dabbrev-downcase nil))
(use-package company-statistics
  :hook
  (after-init-hook . company-statistics-mode))
;;
;; Snippet support
;;
(message "---- YASnippet")
(use-package yasnippet-snippets)
(use-package yasnippet
  :bind
  (:map yas-minor-mode-map
        ("TAB" . nil)
        ([tab]. nil)
        ("C-<tab>" . yas-expand))
  :hook
  (prog-mode . yas-minor-mode)
  (text-mode . yas-minor-mode)
  (vhdl-mode . yas-minor-mode)
  :custom
  (yas-verbosity 2)
  :config
  (yas-reload-all))
;;
;; Treemacs and Icons
;;
(message "---- Treemacs")
(use-package treemacs
  :bind
  (("C-x M-b" . treemacs)
   ("C-t" . treemacs))
  :config
  (setq treemacs-python-executable "c:/Python310/python.exe"))
(use-package treemacs-all-the-icons
  :after (treemacs all-the-icons)
  :config
  ;; The following line will load the theme, but exhibits some
  ;; issues with alignment of the icons and text.
  ;;  (treemacs-load-theme "all-the-icons"))
  ;; This workaround sets up a specific font that does not vary
  ;; in size and is used to handle alignment in the sidebar.
  ;; Then it calls treemacs-load-theme for all-the-icons.
  (treemacs-load-all-the-icons-with-workaround-font "Hermit"))
;; Face colors setup for Gruvbox
(custom-theme-set-faces
 'user
 '(treemacs-file-face ((t (:height 100 :family "Roboto"))))
 '(treemacs-root-face ((t (:inherit treemacs-file-face :foreground "#d3869b" :underline t :weight bold :height 1.2))))
 '(treemacs-directory-face ((t (:inherit treemacs-file-face :foreground "#fabd2f"))))
 '(treemacs-git-added-face ((t (:inherit treemacs-file-face :foreground "#076678"))))
 '(treemacs-git-conflict-face ((t (:inherit treemacs-file-face :foreground "#fb4933"))))
 '(treemacs-git-ignored-face ((t (:inherit treemacs-file-face :foreground "#767676"))))
 '(treemacs-git-modified-face ((t (:inherit treemacs-file-face :foreground "#83a598"))))
 '(treemacs-git-renamed-face ((t (:inherit treemacs-file-face :foreground "#b8bb26"))))
 '(treemacs-git-untracked-face ((t (:inherit treemacs-file-face :foreground "#bcbcbc"))))
 '(treemacs-tags-face ((t (:inherit treemacs-file-face :foreground "#fe8019")))))
                        
;;
;; Magit
;;
(message "---- Magit")
(use-package magit
  :bind
  ("C-x g" . magit-status))
(use-package git-gutter
  :config
  (global-git-gutter-mode 't))
(use-package git-modes)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; KEYBINDS
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "==== Non use-package keybinding ====")
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
(global-set-key (kbd "M-s") 'isearch-forward-symbol-at-point)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)
(global-set-key (kbd "<mouse-4>") 'treemacs)

;; Movement
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
(setq windmove-wrap-around t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; PROGRAMMING MODES
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "==== Specific Coding Mode Setup ====")
;;
;; Emacs Lisp
;;
(put 'add-function 'lisp-indent-function 2)
(put 'advice-add 'lisp-indent-function 2)
(put 'plist-put 'lisp-indent-function 2)
;;
;; VHDL
;;
;; Setting up the most recent version (not on package repositories)
(use-package vhdl-mode
  :load-path "site-lisp/vhdl-mode-3.38.4/")
;; Sets the closing parenthesis to be back one indent level which is not the
;; shipping standard for vhdl-mode.  This function hooks the set offset for
;; the closing argument list and sets it to 0 levels of indentation.
(add-hook 'vhdl-mode-hook
          (lambda ()
            (vhdl-set-offset 'arglist-close 0)))
;; Makes compilation buffer show up horizontal low
(add-to-list 'display-buffer-alist
             '("\\*compilation\\*$" . (display-buffer-below-selected)))
;; Sets my preferred values for vhdl-mode
(setq-default vhdl-basic-offset 4
              vhdl-electric-mode t
              vhdl-indent-tabs-mode nil
              vhdl-project nil
              vhdl-stutter-mode t
              vhdl-array-index-record-field-in-sensitivity-list nil
              vhdl-clock-name "clk"
              vhdl-clock-edge-condition 'function
              vhdl-conditions-in-parenthesis t
              vhdl-date-format "%a %b %e %H:%M:%S %Y"
              vhdl-end-comment-column 80
              vhdl-reset-active-high t
              vhdl-reset-name "reset"
              vhdl-standard '(8 nil)
              vhdl-underscore-is-part-of-word t
              vhdl-upper-case-enum-values t
              vhdl-use-direct-instantiation 'always
              vhdl-platform-spec "Sim: Aldec Riviera-PRO, Synth: Vendor Toolchain (Quartus/Vivado)")
;; Setting up preferred header string
(setq-default vhdl-modify-date-prefix-string "-- Last update : ")
(setq-default vhdl-file-header "\
-------------------------------------------------------------------------------
-- Title       : <title string>
-- Project     : <project>
-------------------------------------------------------------------------------
-- File        : <filename>
-- Author      : <author>
-- Company     : <company>
-- Created     : <date>
-- Last update : <date>
-- Platform    : <platform>
-- Standard    : <standard>
<projectdesc>-------------------------------------------------------------------------------
-- Description: <cursor>
<copyright>-------------------------------------------------------------------------------
-- Revisions: Revisions and commentary regarding such are controlled by
-- the revision control system in use (Rational Team Concert, Git, etc.).
-- Please consult project administrator for access to the VC system.
-------------------------------------------------------------------------------
")
;; Testbench settings
(setq-default vhdl-testbench-include-configuration nil
              vhdl-testbench-include-header t
              vhdl-testbench-include-library t)
(setq-default vhdl-testbench-statements "\
    ------------------------------------------------------------
    -- Clocks and Reset
    -- (Requires tb_util_pkg)
    ------------------------------------------------------------
    CLK_GEN : process
    begin
        create_clock(clk, C_CLK_FREQ);
    end process CLK_GEN;

    RESET_GEN : process
    begin
        reset <= '1',
                 '0' after 20.0*C_CLK_PERIOD * (1 SEC);
        wait;
    end process RESET_GEN;

    ------------------------------------------------------------
    -- Stimulus
    ------------------------------------------------------------
    STIMULUS : process
    begin
        -- Initialization
        wait until reset = '0';

        -- Do stuff

        -- Stop
        std.env.stop(0);
        wait;
    end process STIMULUS;

")
(setq-default vhdl-testbench-declarations "\
    -- Reset and clock declarations
    -- May need to delete clk/reset if they are in the DUT ports.
    signal clk   : std_logic;
    signal reset : std_logic;
    constant C_CLK_FREQ   : real := 100.0e6;          -- Hz
    constant C_CLK_PERIOD : real := 1.0 / C_CLK_FREQ; -- Seconds
")
;;
;;
;; Verilog
;;
;; This uses a newer version on the gnu repo, and loads it from this location
;; instead of the built-in.  use-package (and package.el) has issues with
;; overriding built-in packages.
(use-package verilog-mode
  :load-path "elpa/verilog-mode-2021.10.14.127365406/")
;;
;; Tcl
;;
(setq auto-mode-alist
      (append
       ;; Quartus Settings File is type Tcl
       '(("\\.qsf\\'" . tcl-mode)
       ;; Riviera-Pro/Modelsim Macro Files are type Tcl
         ("\\.do\\'" . tcl-mode)
         ;; Timing constrains are type Tcl
         ("\\.sdc\\'" . tcl-mode))
       auto-mode-alist))
;;
;; JSON
;;
(use-package json-mode)
;;
;; Markdown
;;
(use-package markdown-mode)

(message "==== End of init.el ====")





