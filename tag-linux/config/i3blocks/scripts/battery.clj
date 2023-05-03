#!/usr/bin/env bb

(require '[clojure.java.shell :refer [sh]]
         '[clojure.string :as string])

(defn sh-acpi []
  (-> (sh "acpi" "-b")
      :out
      string/split-lines))

(defn read-acpi [raw-acpi]
  (let [batt-num (str "Battery 0:")]
    (-> raw-acpi
        (as-> lines (filter (fn [line] (string/includes? line batt-num)) lines))
        last
        (string/split (re-pattern batt-num))
        last
        (string/split #",")
        (as-> colls (mapv string/trim colls)))))

(defn get-icon [status percent]
  (case status
    "Full" "󰁹"
    "Discharging" (cond
                    (< percent 10) "󰁺"
                    (< percent 20) "󰁻"
                    (< percent 30) "󰁼"
                    (< percent 40) "󰁽"
                    (< percent 50) "󰁾"
                    (< percent 60) "󰁿"
                    (< percent 70) "󰂀"
                    (< percent 80) "󰂁"
                    (< percent 90) "󰂂"
                    :else "󰂃")
    "Charging" "󰂄"
    "󱉝"))

(defn acpi->output [acpi]
  (let [status (nth acpi 0)
        percent (bigdec (string/replace (nth acpi 1 "0%") "%" ""))
        remain (apply str (take 5 (nth acpi 2 "")))
        icon (get-icon status percent)]
    (str "<span color='#bdbdbd' size='medium'>"
         icon
         "</span> <span>"
         percent "%"
         (when-not (empty? remain)
           (str "(" remain ")"))
         "</span>")))

(-> (sh-acpi)
    read-acpi
    acpi->output
    println)
