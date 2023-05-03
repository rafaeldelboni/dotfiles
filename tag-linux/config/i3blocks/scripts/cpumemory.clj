#!/usr/bin/env bb

(require '[clojure.java.shell :refer [sh]]
         '[clojure.string :as string])

(defn sh-proc [path]
  (-> (sh "cat" path)
      :out
      string/split-lines))

(defn read-memory [raw-memory]
  (->> raw-memory
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

(defn read-cpu [raw-cpu]
  (let [cpu (->> raw-cpu
                 (filter (fn [line] (string/includes? line "cpu MHz")))
                 (mapv (fn [line]
                         (->  line
                              (string/split #":")
                              last
                              string/trim
                              bigdec
                              Math/floor))))
        num (count cpu)]
    (/ (apply + cpu) num)))

(defn procs->output [{:keys [available]} cpu]
  (str "<span color=\"#bdbdbd\" size=\"large\">󰍛 </span><span>"
       (format "%.2f" available)
       " Gb</span>"
       "<span color=\"#bdbdbd\" size=\"large\">  </span><span>"
       (format "%.2f" cpu)
       " MHz</span>"))

(let [memory (-> "/proc/meminfo" sh-proc read-memory)
      cpu (-> "/proc/cpuinfo" sh-proc read-cpu)]
  (println (procs->output memory cpu)))
