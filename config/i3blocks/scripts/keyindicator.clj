#!/usr/bin/env bb

(require '[clojure.java.shell :refer [sh]]
         '[clojure.string :as string])

(defn read-xset-led-mask []
  (-> (sh "xset" "q")
      :out
      string/split-lines
      (as-> lines (filter (fn [line] (string/includes? line "LED mask:")) lines))
      last
      (string/split #"LED mask:")
      last
      string/trim))

(let [caps "<span fgcolor=\"#FFFFFF\" bgcolor=\"#3ea290\">CAPS</span>"
      lock "<span fgcolor=\"#FFFFFF\" bgcolor=\"#3ea290\">NUML</span>"
      mask (read-xset-led-mask)]
  (-> (case mask
        "00000001" caps
        "00000002" lock
        "00000003" (str caps " " lock)
        "")
      println))
