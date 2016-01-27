(defn solve [credit indexed]
  (let [head (first indexed)
        cand (rest indexed)
        matchp #(= credit (+ (last %) (last head)))]
    (if-let [another (first (filter matchp cand))]
      (sort (map first [head another]))
      (recur credit cand))))

(defn answer [credit prices]
  (let [indexed (zipmap (iterate inc 1) prices)]
    (solve credit indexed)))

(dotimes [n (read-string (read-line))]
  (let [[credit _ prices] (repeatedly 3 read-line)
        prices (->> (re-seq #"\d+" prices) (map read-string))
        a (answer (read-string credit) prices)]
    (println (str "Case #" (inc n) ": " (first a) " " (last a)))))
