(defn solve [idx credit prices]
  (let [head (first prices)
        cand (rest prices)]
    (let [another (.indexOf cand (- credit head))]
      (if-not (neg? another)
        [idx (+ idx 1 another)]
        (recur (inc idx) credit cand)))))

(dotimes [n (read-string (read-line))]
  (let [[credit _ prices] (repeatedly 3 read-line)
        prices (->> (re-seq #"\d+" prices) (map read-string))
        a (solve 1 (read-string credit) prices)]
    (println (str "Case #" (inc n) ": " (first a) " " (last a)))))
