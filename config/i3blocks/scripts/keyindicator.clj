#!/usr/bin/env bb

(require '[clojure.java.shell :refer [sh]]
         '[clojure.string :as string])

(defn sh-xset []
  (-> (sh "xset" "q")
      :out
      string/split-lines))

(defn read-xset [raw-xset]
  (-> raw-xset
      (as-> lines (filter (fn [line] (string/includes? line "LED mask:")) lines))
      last
      (string/split #"LED mask:")
      last
      string/trim))

(defn xset->output [xset]
  (let [caps "<span fgcolor=\"#FFFFFF\" bgcolor=\"#2f71bb\">CAPS</span>"
        lock "<span fgcolor=\"#FFFFFF\" bgcolor=\"#2f71bb\">NUML</span>"]
    (case xset
      "00000001" caps
      "00000002" lock
      "00000003" (str caps " " lock)
      "")))

(-> (sh-xset)
    read-xset
    xset->output
    println)
