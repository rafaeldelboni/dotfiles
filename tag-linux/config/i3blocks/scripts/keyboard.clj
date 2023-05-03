#!/usr/bin/env bb

(require '[clojure.java.shell :refer [sh]]
         '[clojure.string :as string])

(defn sh-setxkbmap []
  (-> (sh "setxkbmap" "-query")
      :out
      string/split-lines))

(defn read-setxkbmap [raw-setxkbmap]
  (->> raw-setxkbmap
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

(defn setxkbmap->output [setxkbmap]
  (let [{:keys [layout variant options]
         :or {options ""}} setxkbmap]
    (str "<span color='#bdbdbd' size='large'> </span><span>"
         layout
         " (" variant ")"
         (when (string/includes? options "swapescape")
           " ")
         "</span>")))

(-> (sh-setxkbmap)
    read-setxkbmap
    setxkbmap->output
    println)
