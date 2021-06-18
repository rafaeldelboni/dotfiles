#!/usr/bin/env bb

(require '[clojure.java.shell :refer [sh]]
         '[clojure.string :as string])

(defn sh-amixer []
  (-> (sh "amixer" "sget" "Master")
      :out
      string/split-lines))

(defn read-amixer []
  (let [volume (filter (fn [line] (string/split line #"Left")) (sh-amixer))]
    (-> volume
        last
        (clojure.string/split #"(?<=\[)|(?=\])"))))

(let [volume (nth (read-amixer) 1)
      status (nth (read-amixer) 3)]
  (-> (if (= status "on")
        (str "<span color='#868686' size='large'>墳</span><span> " volume "</span>")
        "<span color='#868686' size='large'>婢</span>")
      println))
