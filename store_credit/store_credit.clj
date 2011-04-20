(require 'clojure.string)

(defstruct item :value :index)
(defn solve [credit items]
	(let [head (first items) 
			r (rest items) 
			found (filter #(= credit (+ (:value %) (:value head))) r)]
		 (if (not-empty found)
			(list head (first found)) 
			(solve credit (rest items)))))


(defn read-int-line [] (Integer/parseInt (read-line)))
(def N (read-int-line))
(dotimes [n N] 
	(let [credit (read-int-line)
			c (read-int-line)
			items (map #(Integer/parseInt %) (clojure.string/split (read-line) #" "))
			indexed-items (map (fn [v i] (struct item v i)) items (iterate inc 1))
			solution (solve credit indexed-items)]
			(println (str "Case #" (+ 1 n) ": " 
					(clojure.string/join " " (sort (map :index solution)))))))
