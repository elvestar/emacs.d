(setq default-fill-column 80)

;;; Backup
(setq
  backup-by-copying t 
  backup-directory-alist '(("." . "~/.backup"))
  delete-old-versions t 
  kept-new-versions 6
  kept-old-versions 2
  version-control t)


;;;
;;; Org Mode
;;;
(add-to-list 'load-path (expand-file-name "/Users/work/github/notes/"))
(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
(require 'org)
;;
;; Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-agenda-files (quote ("~/github/notes/gtd")))

;; Custom Key Bindings
(global-set-key (kbd "<f12>") 'org-agenda)
(global-set-key (kbd "<f5>") 'bh/org-todo)
(global-set-key (kbd "<S-f5>") 'bh/widen)
(global-set-key (kbd "<f7>") 'bh/set-truncate-lines)
(global-set-key (kbd "<f8>") 'org-cycle-agenda-files)
(global-set-key (kbd "<f9> <f9>") 'bh/show-org-agenda)
(global-set-key (kbd "<f9> b") 'bbdb)
(global-set-key (kbd "<f9> c") 'calendar)
(global-set-key (kbd "<f9> f") 'boxquote-insert-file)
(global-set-key (kbd "<f9> g") 'gnus)
(global-set-key (kbd "<f9> h") 'bh/hide-other)
(global-set-key (kbd "<f9> n") 'bh/toggle-next-task-display)
(global-set-key (kbd "<f9> w") 'widen)

(global-set-key (kbd "<f9> I") 'bh/punch-in)
(global-set-key (kbd "<f9> O") 'bh/punch-out)

(global-set-key (kbd "<f9> o") 'bh/make-org-scratch)

(global-set-key (kbd "<f9> r") 'boxquote-region)
(global-set-key (kbd "<f9> s") 'bh/switch-to-scratch)

(global-set-key (kbd "<f9> t") 'bh/insert-inactive-timestamp)
(global-set-key (kbd "<f9> T") 'bh/toggle-insert-inactive-timestamp)

(global-set-key (kbd "<f9> v") 'visible-mode)
(global-set-key (kbd "<f9> l") 'org-toggle-link-display)
(global-set-key (kbd "<f9> SPC") 'bh/clock-in-last-task)
(global-set-key (kbd "C-<f9>") 'previous-buffer)
(global-set-key (kbd "M-<f9>") 'org-toggle-inline-images)
(global-set-key (kbd "C-x n r") 'narrow-to-region)
(global-set-key (kbd "C-<f10>") 'next-buffer)
(global-set-key (kbd "<f11>") 'org-clock-goto)
(global-set-key (kbd "C-<f11>") 'org-clock-in)
(global-set-key (kbd "C-s-<f12>") 'bh/save-then-publish)
(global-set-key (kbd "C-c c") 'org-capture)

; Zhongyi's customize
(global-set-key (kbd "<f10>") 'org-export-dispatch)

(defun bh/hide-other ()
  (interactive)
  (save-excursion
    (org-back-to-heading 'invisible-ok)
    (hide-other)
    (org-cycle)
    (org-cycle)
    (org-cycle)))

(defun bh/set-truncate-lines ()
  "Toggle value of truncate-lines and refresh window display."
  (interactive)
  (setq truncate-lines (not truncate-lines))
  ;; now refresh window display (an idiom from simple.el):
  (save-excursion
    (set-window-start (selected-window)
                      (window-start (selected-window)))))

(defun bh/make-org-scratch ()
  (interactive)
  (find-file "/tmp/publish/scratch.org")
  (gnus-make-directory "/tmp/publish"))

(defun bh/switch-to-scratch ()
  (interactive)
  (switch-to-buffer "*scratch*"))

; 5.1
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
              (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))
(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
              ("NEXT" :foreground "blue" :weight bold)
              ("DONE" :foreground "forest green" :weight bold)
              ("WAITING" :foreground "orange" :weight bold)
              ("HOLD" :foreground "magenta" :weight bold)
              ("CANCELLED" :foreground "forest green" :weight bold)
              ("MEETING" :foreground "forest green" :weight bold)
              ("PHONE" :foreground "forest green" :weight bold))))

; 5.2
(setq org-use-fast-todo-selection t)

; S + cursor will not be treated as state change
(setq org-treat-S-cursor-todo-selection-as-state-change nil)

; 5.3 TODO state triggers
(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING") ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

; 6.1 Capture Templates
(setq org-directory "~/github/notes")
(setq org-default-notes-file "~/github/notes/gtd/refile.org")

;; I use C-c c to start capture mode
(global-set-key (kbd "C-c c") 'org-capture)

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/github/notes/gtd/refile.org")
               "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
              ("r" "respond" entry (file "~/github/notes/gtd/refile.org")
               "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
              ("n" "note" entry (file "~/github/notes/gtd/refile.org")
               "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
              ("j" "Journal" entry (file+datetree "~/github/notes/gtd/diary.org")
               "* %?\n%U\n" :clock-in t :clock-resume t)
              ("w" "org-protocol" entry (file "~/github/notes/gtd/refile.org")
               "* TODO Review %c\n%U\n" :immediate-finish t)
              ("m" "Meeting" entry (file "~/github/notes/gtd/refile.org")
               "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
              ("p" "Phone call" entry (file "~/github/notes/gtd/refile.org")
               "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
              ("h" "Habit" entry (file "~/github/notes/gtd/refile.org")
               "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"<%Y-%m-%d %a .+1d/3d>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

;; Remove empty LOGBOOK drawers on clock out
(defun bh/remove-empty-drawer-on-clock-out ()
  (interactive)
  (save-excursion
    (beginning-of-line 0)
    (org-remove-empty-drawer-at (point))))
(add-hook 'org-clock-out-hook 'bh/remove-empty-drawer-on-clock-out 'append)


; 7 Refiling Tasks
; 
; Targets include this file and any file contributing to the agenda - up to 9 levels deep
(setq org-refile-targets (quote ((nil :maxlevel . 9)
                                 (org-agenda-files :maxlevel . 9))))

; Use full outline paths for refile targets - we file directly with IDO
(setq org-refile-use-outline-path t)

; Targets complete directly with IDO
(setq org-outline-path-complete-in-steps nil)

; Allow refile to create parent tasks with confirmation
(setq org-refile-allow-creating-parent-nodes (quote confirm))

; Use IDO for both buffer and file completion and ido-everywhere to t
(setq org-completion-use-ido t)
(setq ido-everywhere t)
(setq ido-max-directory-size 100000)
(ido-mode (quote both))
; Use the current window when visiting files and buffers with ido
(setq ido-default-file-method 'selected-window)
(setq ido-default-buffer-method 'selected-window)
; Use the current window for indirect buffer display
(setq org-indirect-buffer-display 'current-window)

;;;; Refile settings
; Exclude DONE state tasks from refile targets
(defun bh/verify-refile-target ()
  "Exclude todo keywords with a done state from refile targets"
  (not (member (nth 2 (org-heading-components)) org-done-keywords)))

(setq org-refile-target-verify-function 'bh/verify-refile-target)


; 16 Publishing And Exporting
(setq org-alphabetical-lists t)

;; Explicitly load required exporters
(require 'ox-html)
(require 'ox-latex)
(require 'ox-ascii)

; 16.2 Org-Babel Setup (Org-Babel is necessary for ditaa)
(setq org-ditaa-jar-path "/usr/local/Cellar/ditaa/0.9/libexec/ditaa0_9.jar")
(setq org-plantuml-jar-path "~/java/plantuml.jar")

(add-hook 'org-babel-after-execute-hook 'bh/display-inline-images 'append)

; Make babel results blocks lowercase
(setq org-babel-results-keyword "results")

(defun bh/display-inline-images ()
  (condition-case nil
      (org-display-inline-images)
    (error nil)))

(org-babel-do-load-languages
 (quote org-babel-load-languages)
 (quote ((emacs-lisp . t)
         (dot . t)
         (ditaa . t)
         (R . t)
         (python . t)
         (ruby . t)
         (gnuplot . t)
         (clojure . t)
         (shell . t)
         (ledger . t)
         (org . t)
         (plantuml . t)
         (latex . t))))

; Do not prompt to confirm evaluation
; This may be dangerous - make sure you understand the consequences
; of setting this -- see the docstring for details
(setq org-confirm-babel-evaluate nil)

; Use fundamental mode when editing plantuml blocks with C-c '
(add-to-list 'org-src-lang-modes (quote ("plantuml" . fundamental)))

; 16.7. Publishing Projects
(setq auto-sitemap 1)
; experimenting with docbook exports - not finished
(setq org-export-docbook-xsl-fo-proc-command "fop %s %s")
(setq org-export-docbook-xslt-proc-command "xsltproc --output %s /usr/share/xml/docbook/stylesheet/nwalsh/fo/docbook.xsl %s")
;
; Inline images in HTML instead of producting links to the image
(setq org-html-inline-images t)
; Do not use sub or superscripts - I currently don't need this functionality in my documents
(setq org-export-with-sub-superscripts nil)
; Use org.css from the norang website for export document stylesheets
(setq org-html-head-extra 
    "
    <link href='http://cdn.bootcss.com/bootstrap/2.3.2/css/bootstrap.min.css' rel='stylesheet'>
    <link href='http://cdn.bootcss.com/jquery.tocify/1.7.0/jquery.tocify.css' rel='stylesheet'>
    <link rel='stylesheet' href='org.css' type='text/css' />
    <script src='http://cdn.bootcss.com/bootstrap/2.3.2/js/bootstrap.min.js'></script>
    <script src='http://cdn.bootcss.com/datatables/1.9.4/jquery.dataTables.min.js'></script>
    <script src='http://cdn.bootcss.com/jquery/2.1.0/jquery.min.js'></script>
    <script src='http://cdn.bootcss.com/jqueryui/1.10.3/jquery-ui.min.js'></script>
    <script src='http://cdn.bootcss.com/jquery.tocify/1.7.0/jquery.tocify.min.js'></script>
    ")
(setq org-html-head-include-default-style nil)
; Do not generate internal css formatting for HTML exports
(setq org-export-htmlize-output-type (quote css))
; Export with LaTeX fragments
(setq org-export-with-LaTeX-fragments t)
; Increase default number of headings to export
(setq org-export-headline-levels 6)

(setq org-export-with-toc nil)

(defadvice org-html-paragraph (before fsh-org-html-paragraph-advice
                                      (paragraph contents info) activate)
  "Join consecutive Chinese lines into a single long line without
unwanted space when exporting org-mode to html."
  (let ((fixed-contents)
        (orig-contents (ad-get-arg 1))
        (reg-han "[[:multibyte:]]"))
    (setq fixed-contents (replace-regexp-in-string
                          (concat "\\(" reg-han "\\) *\n *\\(" reg-han "\\)")
                          "\\1\\2" orig-contents))
    (ad-set-arg 1 fixed-contents)
    ))

(setq org-html-postamble t)
(setq org-html-postamble-format 
 '(("en" 
    "
    <script type='text/javascript'>
    content = document.getElementById('content');
    postamble = document.getElementById('postamble');

    document.body.insertBefore(postamble, content);

    container = document.createElement('div');
    container.className = 'container-fluid';
    document.body.insertBefore(container, content);

    row = document.createElement('div');
    row.className = 'row-fluid';
    container.appendChild(row);

    left = document.createElement('div');
    right = document.createElement('div');
    left.className = 'span2';
    right.className = 'span10 offset2';
    row.appendChild(left);
    row.appendChild(right);

    // Left
    // slidebar = document.createElement('div');
    // left.appendChild(slidebar);
    // slidebar.id = 'toc';
    left.id = 'toc';

    // Right 
    right.appendChild(content);
    right.appendChild(postamble);
    </script>

    <script type='text/javascript'>
    $(document).ready(function() {
     //Calls the tocify method on your HTML div.
         var toc = $('#toc').tocify({
            selectors: 'h2, h3',
         }).data('toc-tocify');
    });
    </script>

    <!-- Duoshuo Comment BEGIN -->
    <div class='ds-thread'></div>
    <script type='text/javascript'>
    var duoshuoQuery = {short_name:'elvestar'};
    (function() {
                var ds = document.createElement('script');
                ds.type = 'text/javascript';ds.async = true;
                ds.src = 'http://static.duoshuo.com/embed.js';
                ds.charset = 'UTF-8';
                (document.getElementsByTagName('head')[0] 
                  || document.getElementsByTagName('body')[0]).appendChild(ds);
                })();
    </script>
    <!-- Duoshuo Comment END -->

    <!-- Google Analytics BEGIN -->
    <script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
      (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
      m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
      })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-49036912-1', 'elvestar.com');
    ga('send', 'pageview');

    </script>
    <!-- Google Analytics END -->

    "
    )))


; List of projects
; norang       - ttp://ww.norang.ca/
; doc          - http://doc.norang.ca/
; org-mode-doc - http://doc.norang.ca/org-mode.html and associated files
; org          - miscellaneous todo lists for publishing
(setq org-publish-project-alist
      ;
      ; http://www.norang.ca/  (norang website)
      ; elvestar-org are the org-files that generate the content
      ; norang-extra are images and css files that need to be included
      ; norang is the top-level project that gets published
               ; :publishing-directory "/ssh:root@elvestar.com:/var/www/notes"
      (quote (
              ("elvestar-org"
               :base-directory "~/github/notes/"
               :publishing-directory "~/github/elvestar.github.io/notes/"
               :base-extension "org"
               :exclude "baidu"
               :recursive t
               :auto-sitemap t
               :sitemap-sort-folders "last"
               :table-of-contents nil
               :publishing-function org-html-publish-to-html
               :style-include-default nil
               :section-numbers t
               :table-of-contents nil
               :html-head "
                    <link href='http://cdn.bootcss.com/bootstrap/2.3.2/css/bootstrap.min.css' rel='stylesheet'>
                    <link href='http://cdn.bootcss.com/jquery.tocify/1.7.0/jquery.tocify.css' rel='stylesheet'>
                    <link rel=\"stylesheet\" href=\"/notes/org.css\" type=\"text/css\"/>
                    <script src='http://cdn.bootcss.com/bootstrap/2.3.2/js/bootstrap.min.js'></script>
                    <script src='http://cdn.bootcss.com/datatables/1.9.4/jquery.dataTables.min.js'></script>
                    <script src='http://cdn.bootcss.com/jquery/2.1.0/jquery.min.js'></script>
                    <script src='http://cdn.bootcss.com/jqueryui/1.10.3/jquery-ui.min.js'></script>
                    <script src='http://cdn.bootcss.com/jquery.tocify/1.7.0/jquery.tocify.min.js'></script>
                    "
               :sitemap-title "Elvestar's Notes"
               :author-info nil
               :creator-info nil)
              ("elvestar-extra"
               :base-directory "~/github/notes/"
               :publishing-directory "~/github/elvestar.github.io/notes/"
               :base-extension "css\\|pdf\\|png\\|jpg\\|gif"
               :exclude "baidu"
               :publishing-function org-publish-attachment
               :recursive t
               :author nil)
              ("elvestar"
               :components ("elvestar-org" "elvestar-extra"))

              ("elvestar-org-baidu"
               :base-directory "~/github/notes/baidu"
               :publishing-directory "~/baidu/datateam/zhongyi/notes/baidu"
               :base-extension "org"
               :exclude "^(baidu)"
               :recursive t
               :auto-sitemap t
               :sitemap-sort-folders "last"
               :table-of-contents nil
               :org-html-postamble-format 
               '(("en" 
                  "
                  <script type='text/javascript'>
                  content = document.getElementById('content');
                  postamble = document.getElementById('postamble');

                  document.body.insertBefore(postamble, content);

                  container = document.createElement('div');
                  container.className = 'container-fluid';
                  document.body.insertBefore(container, content);

                  row = document.createElement('div');
                  row.className = 'row-fluid';
                  container.appendChild(row);

                  left = document.createElement('div');
                  right = document.createElement('div');
                  left.className = 'span2';
                  right.className = 'span10 offset2';
                  row.appendChild(left);
                  row.appendChild(right);

                  // Left
                  // slidebar = document.createElement('div');
                  // left.appendChild(slidebar);
                  // slidebar.id = 'toc';
                  left.id = 'toc';

                  // Right 
                  right.appendChild(content);
                  right.appendChild(postamble);
                  </script>

                  <script type='text/javascript'>
                  $(document).ready(function() {
                                               //Calls the tocify method on your HTML div.
                                               var toc = $('#toc').tocify({
                                                                           selectors: 'h2, h3',
                                                                           }).data('toc-tocify');
                                               });
                  </script>
                  "))

                  :publishing-function org-html-publish-to-html
                  :style-include-default nil
                  :section-numbers t
                  :table-of-contents nil
                  :html-head "
                  <link href='http://cdn.bootcss.com/bootstrap/2.3.2/css/bootstrap.min.css' rel='stylesheet'>
                  <link href='http://cdn.bootcss.com/jquery.tocify/1.7.0/jquery.tocify.css' rel='stylesheet'>
                    <link rel=\"stylesheet\" href=\"org.css\" type=\"text/css\"/>
                    <script src='http://cdn.bootcss.com/bootstrap/2.3.2/js/bootstrap.min.js'></script>
                    <script src='http://cdn.bootcss.com/datatables/1.9.4/jquery.dataTables.min.js'></script>
                    <script src='http://cdn.bootcss.com/jquery/2.1.0/jquery.min.js'></script>
                    <script src='http://cdn.bootcss.com/jqueryui/1.10.3/jquery-ui.min.js'></script>
                    <script src='http://cdn.bootcss.com/jquery.tocify/1.7.0/jquery.tocify.min.js'></script>
                    "
               :sitemap-title "百度 | 仲毅的笔记"
               :author-info nil
               :creator-info nil)
              ("elvestar-extra-baidu"
               :base-directory "~/github/notes/baidu"
               :publishing-directory "~/baidu/datateam/zhongyi/notes/baidu"
               :base-extension "css\\|pdf\\|png\\|jpg\\|gif"
               :exclude "^(baidu)"
               :publishing-function org-publish-attachment
               :recursive t
               :author nil)
              ("elvestar-baidu"
               :components ("elvestar-org-baidu" "elvestar-extra-baidu"))
              )))

; I'm lazy and don't want to remember the name of the project to publish when I modify
; a file that is part of a project.  So this function saves the file, and publishes
; the project that includes this file
;
; It's bound to C-S-F12 so I just edit and hit C-S-F12 when I'm done and move on to the next thing
(defun bh/save-then-publish (&optional force)
  (interactive "P")
  (save-buffer)
  (org-save-all-org-buffers)
  (let ((org-html-head-extra)
        (org-html-validation-link "<a href=\"http://validator.w3.org/check?uri=referer\">Validate XHTML 1.0</a>"))
    (org-publish-current-project force)))

(global-set-key (kbd "C-c <f12>") 'bh/save-then-publish)

;;; Font
; (set-frame-font "Menlo-15")
; (set-fontset-font
  ; (frame-parameter nil 'font)
  ; 'han
  ; (font-spec :family "Hiragino Sans GB" ))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/github/notes/gtd/gtd.org")))
 '(send-mail-function (quote smtpmail-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)
