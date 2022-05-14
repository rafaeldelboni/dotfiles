(module config.lang.clojure
  {require {nvim aniseed.nvim
            u aniseed.nvim.util
            core aniseed.core}})

(nvim.echo "lang loaded")

(def- run-lein-cmd "lein repl")
(def- run-deps-cmd 
  (.. "clojure -Sdeps"
      " '{:deps {cider/cider-nrepl {:mvn/version \"0.25.2\"}}}'"
      " -m nrepl.cmdline --middleware '[\"cider.nrepl/cider-middleware\"]' --interactive"))

;; jack in with Lein or Deps based on root project file
(defn run-appropriate-clojure-repl []
  (let [root-files (nvim.fn.readdir (nvim.fn.getcwd))
        has-lein (core.some (fn [s] (= s "project.clj")) root-files)
        has-deps (core.some (fn [s] (= s "deps.edn")) root-files)]
    (if has-lein 
      (do (nvim.echo "found lein")
        (vim.cmd (.. "terminal " run-lein-cmd)))
      has-deps
      (do (nvim.echo "found deps")
        (vim.cmd (.. "terminal " run-deps-cmd)))
      (nvim.echo "can't find neither deps.edn nor project.clj in the root"))))

;; make function available in vim cmd
(u.fn-bridge :RunAppropriateClojureRepl :config.lang.clojure :run-appropriate-clojure-repl)

(nvim.set_keymap :n :<localleader>k ":call RunAppropriateClojureRepl()<cr>" {})
