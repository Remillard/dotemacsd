(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Man-notify-method 'aggressive t)
 '(bookmark-save-flag 1)
 '(completion-category-overrides '((file (styles partial-completion))))
 '(completion-cycle-threshold 3)
 '(completion-styles '(orderless basic))
 '(completions-detailed t)
 '(corfu-auto t)
 '(corfu-auto-prefix 2)
 '(corfu-cycle t)
 '(custom-safe-themes
   '("3ca84532551daa1b492545bbfa47fd1b726ca951d8be29c60a3214ced30b86f5" default))
 '(dired-auto-revert-buffer t)
 '(dired-dwim-target t)
 '(ediff-window-setup-function 'ediff-setup-windows-plain t)
 '(eglot-autoshutdown t t)
 '(eshell-scroll-to-bottom-on-input 'this t)
 '(fancy-splash-image
   "c:/Users/nor71443/.emacs.d/crafted-emacs/system-crafters-logo.png")
 '(fast-but-imprecise-scrolling t)
 '(global-auto-revert-non-file-buffers t)
 '(ibuffer-movement-cycle nil)
 '(ibuffer-old-time 24)
 '(kill-do-not-save-duplicates t)
 '(latex-run-command "pdflatex")
 '(load-prefer-newer t t)
 '(magit-git-executable "C:/Program Files/Git/cmd/git.exe")
 '(magit-repository-directories
   '(("c:/users/nor71443/projects" . 1)
     ("c:/users/nor71443/.emacs.d" . 0)))
 '(marginalia-annotators
   '(marginalia-annotators-heavy marginalia-annotators-light nil) t)
 '(markdown-enable-html t)
 '(markdown-enable-math t)
 '(org-export-backends '(ascii html icalendar latex md odt))
 '(org-hide-emphasis-markers t t)
 '(org-link-descriptive t t)
 '(org-mouse-1-follows-link t t)
 '(org-return-follows-link t t)
 '(package-archive-priorities
   '(("gnu" . 99)
     ("nongnu" . 80)
     ("stable" . 70)
     ("melpa" . 0)))
 '(package-selected-packages
   '(python-black elpy json-mode whole-line-or-region bufler git-modes git-gutter magit treemacs yasnippet yasnippet-snippets counsel-etags multiple-cursors deadgrep move-text smartparens rainbow-delimiters solaire-mode doom-modeline ef-themes modus-themes doom-themes vscode-dark-plus-theme auctex-latexmk auctex pandoc-mode markdown-mode tabspaces helpful elisp-demos all-the-icons org-appear denote ibuffer-project aggressive-indent editorconfig treesit-auto vertico orderless marginalia embark-consult embark corfu-terminal corfu consult cape compat))
 '(python-black-command "c:/Python311/Scripts/black.exe")
 '(python-black-extra-args nil)
 '(scroll-conservatively 101)
 '(scroll-margin 0)
 '(scroll-preserve-screen-position t)
 '(speedbar-frame-parameters
   '((name . "speedbar")
     (title . "speedbar")
     (minibuffer)
     (border-width . 2)
     (menu-bar-lines . 0)
     (tool-bar-lines . 0)
     (unsplittable . t)
     (left-fringe . 10)))
 '(speedbar-update-flag t)
 '(speedbar-use-images nil)
 '(switch-to-buffer-in-dedicated-window 'pop)
 '(switch-to-buffer-obey-display-actions t)
 '(tab-always-indent 'complete)
 '(tabspaces-include-buffers '("*scratch*"))
 '(tabspaces-mode t)
 '(tabspaces-remove-to-default t)
 '(tabspaces-use-filtered-buffers-as-default t)
 '(verilog-auto-delete-trailing-whitespace t)
 '(verilog-auto-lineup 'all)
 '(verilog-case-indent 4)
 '(verilog-cexp-indent 4)
 '(verilog-indent-level 4)
 '(verilog-indent-level-behavioral 4)
 '(verilog-indent-level-declaration 4)
 '(verilog-indent-level-directive 4)
 '(verilog-indent-level-module 4)
 '(vertico-cycle t)
 '(vhdl-compiler "Aldec")
 '(vhdl-project "AVX-10K FPGA")
 '(vhdl-project-alist
   '(("IFF-45TS DIAC Board FPGA" "IFF-45TS Next Generation w/ Arria 10 SX660 FPGA" "c:/Users/nor71443/projects/iff45ts-diac-fpga/"
      ("board_p1/src/" "common/src/")
      ""
      (("Aldec" "-dbg -2008 -work \\1" "-f \\1 top_level" nil))
      "sim/" "work" "lib/" "Makefile_\\2" "")
     ("AVX-10K FPGA" "AVX10k Aircraft Radio Ramp Tester" "c:/Users/nor71443/projects/onx-avx-fpga/"
      ("common/src/" "22133029/src/" "22163520/src/" "22166061/src/")
      ""
      (("Aldec" "-dbg -2008 -work \\1" "-f \\1 top_level" nil))
      "sim/" "work" "sim/rp_onx10k_work/" "Makefile_\\2" "")
     ("GPSG-1010 Upconverter" "GPSG-1010 Upconverter" "c:/Users/nor71443/projects/gpsg-upconverter-fpga/"
      ("hdl/")
      ""
      (("Aldec" "-dbg -2008 -work \\1" "-f \\1 top_level" nil))
      "simulation/" "work" "simulation/work/" "Makefile_\\2" "")))
 '(vhdl-testbench-include-custom-library "use work.tb_util_pkg.all;")
 '(vhdl-testbench-include-libraries '(nil t t t nil nil nil nil t))
 '(xref-show-definitions-function 'xref-show-definitions-completing-read))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Inconsolata" :foundry "outline" :slant normal :weight regular :height 141 :width normal)))))
