(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(completion-category-overrides '((file (styles partial-completion))))
 '(completion-styles '(orderless basic))
 '(corfu-auto t)
 '(corfu-auto-delay 0.0)
 '(corfu-auto-prefix 2)
 '(corfu-cycle t)
 '(corfu-echo-documentation 0.25 t)
 '(magit-git-executable "C:/Program Files/Git/cmd/git.exe")
 '(magit-repository-directories
   '(("c:/users/nor71443/projects" . 1)
     ("c:/users/nor71443/.emacs.d" . 0)))
 '(marginalia-annotators
   '(marginalia-annotators-heavy marginalia-annotators-light nil) t)
 '(package-archive-priorities
   '(("gnu" . 99)
     ("nongnu" . 80)
     ("stable" . 70)
     ("melpa" . 0)))
 '(package-selected-packages
   '(corfu-terminal corfu yasnippet-snippets whole-line-or-region vscode-dark-plus-theme vertico use-package treemacs-all-the-icons solaire-mode smartparens rainbow-delimiters multiple-cursors move-text markdown-mode marginalia magit json-mode git-modes git-gutter doom-themes doom-modeline deadgrep counsel-etags consult cape bufler benchmark-init))
 '(package-user-dir "c:/Users/nor71443/.emacs.d/elpa/")
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
      "sim/" "work" "sim/rp_onx10k_work/" "Makefile_\\2" "")))
 '(vhdl-testbench-include-custom-library "use work.tb_util_pkg.all;")
 '(vhdl-testbench-include-libraries '(nil t t t nil nil nil nil t)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Roboto Mono" :foundry "outline" :slant normal :weight normal :height 120 :width normal))))
 '(treemacs-directory-face ((t (:inherit treemacs-file-face :foreground "#fabd2f"))))
 '(treemacs-file-face ((t (:height 100 :family "Roboto"))))
 '(treemacs-git-added-face ((t (:inherit treemacs-file-face :foreground "#076678"))))
 '(treemacs-git-conflict-face ((t (:inherit treemacs-file-face :foreground "#fb4933"))))
 '(treemacs-git-ignored-face ((t (:inherit treemacs-file-face :foreground "#767676"))))
 '(treemacs-git-modified-face ((t (:inherit treemacs-file-face :foreground "#83a598"))))
 '(treemacs-git-renamed-face ((t (:inherit treemacs-file-face :foreground "#b8bb26"))))
 '(treemacs-git-untracked-face ((t (:inherit treemacs-file-face :foreground "#bcbcbc"))))
 '(treemacs-root-face ((t (:inherit treemacs-file-face :foreground "#d3869b" :underline t :weight bold :height 1.2))))
 '(treemacs-tags-face ((t (:inherit treemacs-file-face :foreground "#fe8019")))))
