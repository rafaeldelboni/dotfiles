{:user {:plugins [[cider/cider-nrepl "0.22.0"]]}
 :repl {:dependencies [[olical/propel "1.0.0"]]
        :repl-options
        {:init
          (do (require 'propel.core)
              (let [prepl (propel.core/start-prepl! {:port-file? true})]
                (println "pREPL server started on port"
                         (:port prepl)
                         "on host"
                         (:address prepl))))}}}
