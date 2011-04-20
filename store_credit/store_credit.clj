(require 'clojure.string)

(defstruct item :value :index)
(defn solve [credit items]
	(let [head (first items) 
			r (rest items) 
			found (filter #(= credit (+ (:value %) (:value head))) r)]
		 (if (not-empty found)
			(list head (first found)) 
			(solve credit r))))


(defn read-int-line [] (Integer/parseInt (read-line)))

(defn read-ints-from-a-line [line]
	(map #(Integer/parseInt %) (clojure.string/split line #" ")))

(defn indexed-items [line]
	(map (fn [v i] (struct item v i)) (read-ints-from-a-line line) (iterate inc 1)))

(defn get-sorted-indice [solution]
	(sort (map #(:index %) solution)))

(defn print-result [n indice] 
	(println (str "Case #" (+ 1 n) ": " (clojure.string/join " " indice))))
		
(dotimes [n (read-int-line)] 
	(let [credit (read-int-line)]
		(read-int-line)
		(print-result n (get-sorted-indice (solve credit (indexed-items (read-line)))))))
