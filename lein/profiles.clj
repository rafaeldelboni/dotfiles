{:user
 {:min-lein-version    "2.9.0"
  :repositories        [["central"  {:url "https://repo1.maven.org/maven2/" :snapshots false}]
                        ["clojars"  {:url "https://clojars.org/repo/"}]
                        ["nu-maven" {:url "s3p://nu-maven/releases/" :region "sa-east-1"}]]
  :plugin-repositories [["nu-maven" {:url "s3p://nu-maven/releases/"}]]
  :jvm-opts            ["-Djava.locale.providers='COMPAT,JRE,CLDR'"]
  :plugins             [[s3-wagon-private "1.3.5"]
                        [com.jakemccrary/lein-test-refresh "0.25.0"]
                        [lein-ancient "0.7.1-SNAPSHOT"]]}

 :test {:dependencies [[cljdev "0.10.2"]]
        :injections   [(require 'nu)]}

 :repl {;; If you need to have `cider-nrepl` and `refactor-nrepl` in your REPL
        ;; session (i.e.: vim-users), uncomment the following lines
        ;; :plugins [[cider/cider-nrepl "0.25.3"]
        ;;           [refactor-nrepl "2.5.0-SNAPSHOT"]]
        :repl-options {:timeout 300000}
        :dependencies [[cljdev "0.10.2"]]
        :injections   [(require 'nu)]}}
