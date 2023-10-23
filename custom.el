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
 '(custom-safe-themes
   '("3ca84532551daa1b492545bbfa47fd1b726ca951d8be29c60a3214ced30b86f5" "277a5bce12d6957dbabb43a2f55ee2b6371388b749cbb29fd251df19334a1f0b" "41bbaed6a17405ee6929c7e1f8035cffd05d0ebf3f08ce388da0e92c63fb6cef" "e5a748cbefd483b74b183d7da4fca6228207a6bf9be9792dc85403a186724e1f" "68b35e92f9daa37685218bd11aa5307140a0ec4c8fd17142a83457619e7b1240" "dde643b0efb339c0de5645a2bc2e8b4176976d5298065b8e6ca45bc4ddf188b7" "30dc9873c16a0efb187bb3f8687c16aae46b86ddc34881b7cae5273e56b97580" "443e2c3c4dd44510f0ea8247b438e834188dc1c6fb80785d83ad3628eadf9294" "adaf421037f4ae6725aa9f5654a2ed49e2cd2765f71e19a7d26a454491b486eb" "e09401ab2c457e2e4d8b800e1c546dbc8339dc33b2877836ba5d9b6294ae6e55" "aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "00cec71d41047ebabeb310a325c365d5bc4b7fab0a681a2a108d32fb161b4006" "56044c5a9cc45b6ec45c0eb28df100d3f0a576f18eef33ff8ff5d32bac2d9700" "7a424478cb77a96af2c0f50cfb4e2a88647b3ccca225f8c650ed45b7f50d9525" "1a1ac598737d0fcdc4dfab3af3d6f46ab2d5048b8e72bc22f50271fd6d393a00" "c865644bfc16c7a43e847828139b74d1117a6077a845d16e71da38c8413a5aaa" "2721b06afaf1769ef63f942bf3e977f208f517b187f2526f0e57c1bd4a000350" "da75eceab6bea9298e04ce5b4b07349f8c02da305734f7c0c8c6af7b5eaa9738" "dc8285f7f4d86c0aebf1ea4b448842a6868553eded6f71d1de52f3dcbc960039" "be84a2e5c70f991051d4aaf0f049fa11c172e5d784727e0b525565bb1533ec78" "ddffe74bc4bf2c332c2c3f67f1b8141ee1de8fd6b7be103ade50abb97fe70f0c" "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" "e3daa8f18440301f3e54f2093fe15f4fe951986a8628e98dcd781efbec7a46f2" default))
 '(latex-run-command "pdflatex")
 '(magit-git-executable "C:/Program Files/Git/cmd/git.exe")
 '(magit-repository-directories
   '(("c:/users/nor71443/projects" . 1)
     ("c:/users/nor71443/.emacs.d" . 0)))
 '(marginalia-annotators
   '(marginalia-annotators-heavy marginalia-annotators-light nil) t)
 '(org-export-backends '(ascii html icalendar latex md odt))
 '(package-selected-packages
   '(verilog-ts-mode vhdl-ts-mode matlab-mode all-the-icons treemacs-nerd-icons treemacs auctex ef-themes modus-themes dirvish yaml-mode tree-sitter-indent emojify display-wttr-hook display-wttr weather-metno wttrin denote elpy jira-jump python-black orderless embark-consult embark org org-contacts org-appear corfu-terminal corfu yasnippet-snippets whole-line-or-region vscode-dark-plus-theme vertico use-package treemacs-all-the-icons solaire-mode smartparens rainbow-delimiters multiple-cursors move-text markdown-mode marginalia magit json-mode git-modes git-gutter doom-themes doom-modeline deadgrep counsel-etags consult cape bufler benchmark-init))
 '(package-user-dir "c:/Users/nor71443/.emacs.d/elpa/")
 '(python-black-command "c:/Python311/Scripts/black.exe")
 '(python-black-extra-args nil)
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
 '(vhdl-testbench-include-libraries '(nil t t t nil nil nil nil t)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
