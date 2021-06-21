#!/usr/bin/env bb

(require '[babashka.curl :as curl]
         '[cheshire.core :as json])

(def coindesk-url "https://api.coindesk.com/v1/bpi/currentprice.json")

(defn curl-coindesk []
  (let [result (curl/get coindesk-url {:throw false})]
    (if (= (:status result) 200)
      (-> result
          :body
          (json/parse-string true))
      (do (println (assoc result :error (str "error on " coindesk-url)))
          (System/exit 1)))))

(defn read-coindesk [raw-coindesk]
  (-> raw-coindesk
      (get-in [:bpi :USD :rate_float])
      bigdec))

(defn coindesk->output [coindesk]
  (str "<span color=\"#868686\" size=\"large\"> </span><span>$"
       (format "%.2f" coindesk)
       "</span>"))

(-> (curl-coindesk)
    read-coindesk
    coindesk->output
    println)
