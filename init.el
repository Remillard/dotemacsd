;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; INITIALIZATION
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "==== Initial Bootstrap ====")
;;
;; FILE LOCATIONS
;; Emacs Customization File
;;
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
(put 'dired-find-alternate-file 'disabled nil)
;;
;; Temporary Directory for backups and whatnot.
;;
(setq temporary-file-directory "c:/temp/")
;;
;; Additional modules (some from Crafted Emacs)
;;
(add-to-list 'load-path (expand-file-name "site-lisp/" user-emacs-directory))
(add-to-list 'load-path (expand-file-name "crafted-lisp/" user-emacs-directory))
;;
;; Setting up package retrieval with `package.el` and using Crafted Emacs
;; bootstrap file.
;;
(defvar crafted-config-path user-emacs-directory)
(defvar crafted-config-var-directory (expand-file-name "var/" crafted-config-path))
(defvar crafted-config-etc-directory (expand-file-name "etc/" crafted-config-path))
(defvar crafted-bootstrap-directory (expand-file-name "crafted-lisp/" crafted-config-path)
  "Crafted Emacs lisp module location")
(load (expand-file-name "crafted-package.el" crafted-bootstrap-directory))
(crafted-package-bootstrap crafted-package-system)
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
;; Increasing the garbage collection threshold The default garbage collection
;; threshold is 800 kB, and increasing this to 10 MB for start up increases the
;; speed.
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

(setq dired-listing-switches "-aBhl --group-directories-first")
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
;; Spelling (requires Hunspell and dictionaries.
;; Via Chocolatey:
;; - choco install hunspell.portable
;; Libraries:
;; - wget -O en_US.aff https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/en_US.aff?id=a4473e06b56bfe35187e302754f6baaa8d75e54f
;; - wget -O en_US.dic https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/en_US.dic?id=a4473e06b56bfe35187e302754f6baaa8d75e54f
;; - Place in "c:/Hunspell/" (or wherever DICPATH below is set.)
;;
(message "---- Spelling")
(setenv "LANG" "en_US")
(setenv "DICTIONARY" "en_US")
(setenv "DICPATH" (expand-file-name "c:/Hunspell/"))
(setq ispell-program-name (executable-find "hunspell")
      flyspell-issue-message-flag t
      ispell-highlight-p t
      ispell-silently-savep t
      ispell-current-dictionary "en_US"
      ispell-hunspell-dict-paths-alist
      '(("en_US" "c:/Hunspell/en_US.aff"))
      ispell-dictionary "en_US")
(add-hook 'text-mode-hook #'flyspell-mode)
(add-hook 'prog-mode-hook #'flyspell-prog-mode)
;;
;; Personal Information Settings
;; This way I can have an identity for work and one for home and just
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
  :ensure t
  :if (display-graphic-p))
(use-package vscode-dark-plus-theme)
(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-one t)
  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config)
  (setq doom-themes-treemacs-theme "doom-colors")
  (doom-themes-treemacs-config)
  (doom-themes-org-config))
;;
;; Doom Modeline
;;
(use-package doom-modeline
  :init (doom-modeline-mode 1))
;;
;; Font(s)
;;
(set-frame-font "Inconsolata 14" nil t)
;;(set-frame-font "Roboto Mono 12" nil t)
;;(set-frame-font "Consolas 14" nil t)
;;(set-frame-font "Cascadia Code Light 12" nil t)
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
(menu-bar-mode 1)
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
;; Completion package from Crafted Emacs which puts in a bunch of stuff with
;; decent configurations.
;;
(message "---- Completion (Crafted Emacs module)")
(require 'crafted-completion)
;;
;; Org settings package from Crafted Emacs making a few basic settings for
;; org-mode.
;; 
;;
(message "---- Org Mode (Crafted Emacs module)")
(require 'crafted-org)
;;
;; Company completion tools When coming back to this (if ever) see reddit thread
;; where it is suggested how to debug it, and how to use dabbrev-code.
;;
;; (message "---- Company")
;; (use-package company
;;   :config
;;   (setq company-backends '(company-dabbrev))
;;   (setq company-dabbrev-ignore-case nil)
;;   (setq company-dabbrev-downcase nil)
;;   :init
;;   (global-company-mode 1))
;; (use-package company-statistics
;;   :hook
;;   (after-init-hook . company-statistics-mode))
;;
;; Counsel
;;
(message "---- Counsel Etags")
(use-package counsel-etags
  :ensure t
  :init
  (add-hook 'prog-mode-hook
            (lambda ()
              (add-hook 'after-save-hook
                        'counsel-etags-virtual-update-tags 'append 'local)))
  :config
  (setq counsel-etags-update-interval 60)
  (push "build" counsel-etags-ignore-directories))
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

;;
;; Bufler (Buffer Butler)
;;
(message "---- Bufler")
(use-package bufler
  :bind
  ("C-x C-b" . bufler-list)
  :config
  (bufler-mode))
;;
;; Whole line or region
;;
(use-package whole-line-or-region
  :config
  (whole-line-or-region-global-mode))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; KEYBINDS
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "==== Non use-package keybinding ====")
;; Set this if not using Bufler
;;(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
(global-set-key (kbd "M-s") 'isearch-forward-symbol-at-point)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)
(global-set-key (kbd "<mouse-4>") 'treemacs)
(global-set-key (kbd "M-i") 'imenu)
(global-set-key (kbd "<f6>") 'counsel-etags-find-tag-at-point)
(global-set-key (kbd "<f7>") 'ispell-word)
(global-set-key (kbd "<f8>") 'flyspell-correct-word)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C-=") 'text-scale-decrease)
(global-unset-key (kbd "C-<wheel-up>"))
(global-unset-key (kbd "C-<wheel-down>"))

;; Movement
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
(setq windmove-wrap-around t)
;;
;; Hotkey for configuration file
;;
(defun find-config ()
  "Edit init.el"
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "C-c I") 'find-config)
;;
;; Jira Jump
;;
;; (use-package jira-jump
;;   :load-path "site-lisp/jira-jump/"
;;   :ensure
;;   :config
;;   (setq jira-jump--projects
;;       '(("EAR" . ((instance . "https://jira1.ds.jdsu.net/jira")
;;                       (projects . ("AVX10K-"))))
;;         ("ITAR" . ((instance . "http://wic-jira.viavisolutions.com")
;;                    (projects . ("IFF45TS-")))))))


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
              vhdl-compiler "Aldec"
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
              vhdl-testbench-include-library t
              vhdl-testbench-include-libraries '(nil t t t nil nil nil nil t)
              vhdl-testbench-include-custom-library "use work.tb_util_pkg.all;")
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
;;
;; Python
;;
(use-package elpy
  :ensure t
  :init
  (elpy-enable))
(use-package python-black)
(eval-after-load 'python
  '(define-key python-mode-map (kbd "C-c C-b") 'python-black-buffer))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; CUSTOM FUNCTIONS
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(message "==== Custom Functions ====")
(defun avx10k-dired ()
  (interactive)
  (let ((first-address (read-string "Unit address: ")))
    (dired (concat "/plink:root@" first-address "|ssh:root@192.168.100.11:/root"))))

(message "==== End of init.el ====")
