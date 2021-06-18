#!/usr/bin/env bb

(require '[clojure.java.shell :refer [sh]]
         '[clojure.string :as string])

(defn sh-acpi []
  (-> (sh "acpi" "-b")
      :out
      string/split-lines))

(defn read-acpi []
  (let [batt-num (str "Battery 0:")]
    (-> (sh-acpi)
        (as-> lines (filter (fn [line] (string/includes? line batt-num)) lines))
        last
        (string/split (re-pattern batt-num))
        last
        (string/split #",")
        (as-> colls (mapv string/trim colls)))))

(defn get-icon [status percent]
  (case status
    "Discharging" (cond
                    (< percent 10) ""
                    (< percent 20) ""
                    (< percent 30) ""
                    (< percent 40) ""
                    (< percent 50) ""
                    (< percent 60) ""
                    (< percent 70) ""
                    (< percent 80) ""
                    (< percent 90) ""
                    :else "")
    "Charging" ""
    ""))

(let [infos (read-acpi)
      status (nth infos 0)
      percent (bigdec (string/replace (nth infos 1 "0%") "%" ""))
      remain (apply str (take 5 (nth infos 2)))
      icon (get-icon status percent)]
  (-> (str "<span color='#868686' size='medium'>"
           icon
           "</span> <span>"
           percent "%(" remain ")"
           "</span>")
      println))
