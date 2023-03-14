{:user
 {:min-lein-version    "2.9.0"
  :repositories        [["nu-codeartifact" {:url "https://maven.cicd.nubank.world"}]]
  :plugin-repositories [["nu-codeartifact" {:url "https://maven.cicd.nubank.world"}]]
  :jvm-opts            ["-Djava.locale.providers=COMPAT,JRE,CLDR"
                        "-Dclojure.core.async.go-checking=true" ;; Enables strict checks of blocking calls inside core.async `go` context
                        "--illegal-access=deny"]            ;; Note: this option was removed in Java 17
  :plugins             [[com.jakemccrary/lein-test-refresh "0.25.0"]
                        [lein-ancient "1.0.0-RC3"]]}

 :test {:dependencies [[cljdev "0.11.0"]]
        :injections   [(require 'nu)]}

 :repl {;; If you need to have `cider-nrepl` and `refactor-nrepl` in your REPL
        ;; session (i.e.: vim-users), uncomment the following lines
        ;; :plugins [[cider/cider-nrepl "0.25.3"]
        ;;           [refactor-nrepl "2.5.0-SNAPSHOT"]]
        :plugins      [[cider/cider-nrepl "0.28.7"]]
        :repl-options {:timeout 300000}
        :dependencies [[cljdev "0.11.0"]]
        :injections   [(require 'nu)]}}
