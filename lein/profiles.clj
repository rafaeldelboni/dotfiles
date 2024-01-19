{:user
 {:min-lein-version    "2.10.0"
  :repositories        [["nu-codeartifact" {:url "https://maven.cicd.nubank.world"}]]
  :plugin-repositories [["nu-codeartifact" {:url "https://maven.cicd.nubank.world"}]]
  :jvm-opts            [;; Uses locale compatibility mode, because existing code expects JDK8
                        ;; behavior when formatting time and money
                        "-Djava.locale.providers=COMPAT,CLDR"
                        ;; Enables strict checks of blocking calls inside core.async `go` context
                        "-Dclojure.core.async.go-checking=true"]
  :plugins             [[com.jakemccrary/lein-test-refresh "0.25.0"]
                        [lein-ancient "1.0.0-RC3"]]

  :dependencies [[cljdev "0.11.8"]]
  :injections   [(require 'nu)]}

 :repl {;; If you need to have `cider-nrepl` and `refactor-nrepl` in your REPL
        ;; session (i.e.: vim-users), uncomment the following lines
        ;; :plugins [[cider/cider-nrepl "0.30.0"]
        ;;           [refactor-nrepl "2.5.0-SNAPSHOT"]]
        :plugins      [[cider/cider-nrepl "0.45.0"]]
        :repl-options {:timeout 300000}}}
