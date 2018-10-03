for i in $(seq 101 2549)
do 
	let "j = i - 100"
	mv $[i].png $[j].png
 done
