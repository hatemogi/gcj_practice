(require 'clojure.string)

(defn target_pos [color seqs org]
	(let [found (filter (fn [v] (= (first v) color)) seqs)]
		(if (empty? found)
			org
			(Integer/parseInt (last (first found))))))
	
(defn new_value [tv ov dist]
	(if (> tv ov) (+ ov dist) (- ov dist)))
		
(defn solve [seqs o b]
	(if (empty? seqs) 
		0
		(let [to (target_pos "O" seqs o) tb (target_pos "B" seqs b)
				job (first seqs)
				dist_o (Math/abs (- to o)) dist_b (Math/abs (- tb b))
				req_s (if (= (first job) "O") (+ 1 dist_o) (+ 1 dist_b))]		
			(+ req_s (solve (rest seqs) (new_value to o (min dist_o req_s)) (new_value tb b (min dist_b req_s)))))))		
	
(defn read-int-line [] (Integer/parseInt (read-line)))

(defn print-result [n value] 
	(println (str "Case #" (+ 1 n) ": " value)))
	
(defn makeq [str]
	(for [pair (re-seq #"\w \d+" str)] (seq (clojure.string/split pair #" "))))

(dotimes [no (read-int-line)] 
	(let [s (clojure.string/split (read-line) #" ")]
		(print-result no (solve (makeq (clojure.string/join " " (rest s))) 1 1))))
