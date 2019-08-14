{:user {:plugins [[cider/cider-nrepl "0.21.1"]]}
 :repl {:repl-options
        {:init
         (do (println "pREPL server started on port 55555 on localhost")
             (clojure.core.server/start-server {:accept 'clojure.core.server/io-prepl :address "localhost" :port 55555 :name "lein"}))}}}
