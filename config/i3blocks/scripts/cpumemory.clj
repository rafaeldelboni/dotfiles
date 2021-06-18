#!/usr/bin/env bb

(require '[clojure.java.shell :refer [sh]]
         '[clojure.string :as string])

(defn sh-proc [path]
  (-> (sh "cat" path)
      :out
      string/split-lines))

(defn read-memory []
  (->> (sh-proc "/proc/meminfo")
       (filter (fn [line] (string/includes? line "Mem")))
       (mapv (fn [line]
               (let [coll (string/split line #":")]
                 {(-> coll
                      first
                      string/lower-case
                      (string/replace #"mem" "")
                      keyword)
                  (-> coll
                      last
                      (string/replace #" kB" "")
                      string/trim
                      bigdec
                      (/ 1000000))})))
       (reduce merge)))

(defn read-cpu []
  (let [cpu (->> (sh-proc "/proc/cpuinfo")
                 (filter (fn [line] (string/includes? line "cpu MHz")))
                 (mapv (fn [line]
                         (->  line
                              (string/split #":")
                              last
                              string/trim
                              bigdec))))
        num (count cpu)]
    (/ (apply + cpu) num)))

(let [{:keys [available]} (read-memory)
      cpu (read-cpu)]
  (-> (str "<span color=\"#868686\" size=\"large\"> </span><span>"
       (format "%.2f" available)
       " Gb</span>"
       "<span color=\"#868686\" size=\"large\"> ﬙ </span><span>"
       (format "%.2f" cpu)
       " MHz</span>")
      println))
