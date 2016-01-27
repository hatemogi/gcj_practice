(defn solve [credit indexed]
  (let [head (first indexed)
        cand (rest indexed)
        match #(= credit (+ (:val %) (:val head)))]
    (if-let [another (first (filter match cand))]
      (sort (map :idx [head another]))
      (recur credit cand))))

(defn answer [[credit _ prices]]
  (let [credit (read-string credit)
        prices (->> (re-seq #"\d+" prices)
                    (map read-string))
        indexed (map #(hash-map :idx %1 :val %2) (iterate inc 1) prices)]
    (solve credit indexed)))

(defn format-answers [answers]
  (map #(str "Case #" %1 ": " (first %2) " " (last %2))
       (iterate inc 1)
       answers))

(let [lines (rest (line-seq (java.io.BufferedReader. *in*)))
      problems (partition 3 lines)]
  (doseq [answer (format-answers (map answer problems))]
    (println answer)))
