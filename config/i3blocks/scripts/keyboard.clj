#!/usr/bin/env bb

(require '[clojure.java.shell :refer [sh]]
         '[clojure.string :as string])

(defn read-setxkbmap []
  (->> (sh "setxkbmap" "-query")
       :out
       string/split-lines
       (mapv (fn [line]
               (let [coll (string/split line #":")]
                 {(-> coll
                      first
                      string/lower-case
                      keyword)
                  (-> coll
                      last
                      string/trim)})))
       (reduce merge)))

(let [{:keys [layout variant options]
       :or {options ""}} (read-setxkbmap)]
  (-> (str "<span color='#868686' size='large'> </span><span>"
           layout
           " (" variant ")"
           (when (string/includes? options "swapescape") " ")
           "</span>")
      println))
