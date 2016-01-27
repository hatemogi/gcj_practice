;; https://code.google.com/codejam/contest/dashboard?c=351101
;; $ java -jar ./clojure-1.8.0.jar store_credit.clj < A-large-practice.in > A-large-clj.out

(defn solve [idx credit prices]
  (let [head (first prices)
        cand (rest prices)
        another (+ idx 1 (.indexOf cand (- credit head)))]
    (if (< idx another)
      [idx another]
      (recur (inc idx) credit cand))))

(dotimes [n (read-string (read-line))]
  (let [[credit _ prices] (repeatedly 3 read-line)
        prices (map read-string (re-seq #"\d+" prices))
        a (solve 1 (read-string credit) prices)]
    (println (str "Case #" (inc n) ": " (a 0) " " (a 1)))))
