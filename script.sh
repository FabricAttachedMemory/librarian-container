#!/bin/bash
#A script designed to write a .ini file for book_register.py, and finally run librarian.py

read -p "Enter the name of your .ini file: " name_of_file
read -p "Enter your desired number of nodes: " nodes
read -p "Enter book size bytes: " book_size 

declare -a sizes
index=0
number=1

read -p "Do you want all the nodes to have the same amount of memory? " yes_no
if [[ "$yes_no" == "y" ]]; then
	read -p "Enter the amount of memory per node: " mem_size
	for ((i=1;i<=$nodes;i++)); do
		sizes[$index]=$mem_size
		let index+=1
	done
else 
	for ((i=1;i<=$nodes;i++)); do
        	read -p "Enter the amount of memory/NVM for node $number: " sizes[index]
		let index+=1
		let number+=1
	done	
fi


read -p "Enter the name of your .db file: " db_file

#check if file is created, if it is just call the commands

if [ -e "$name_of_file" ]; then 
	if [ -e tm-librarian/"$db_file" ]; then
		tm-librarian/./librarian.py --db_file tm-librarian/"$db_file"
		exit
	else
		tm-librarian/./book_register.py -d tm-librarian/"$db_file" "$name_of_file"
		tm-librarian/./librarian.py --db_file tm-librarian/"$db_file"
		exit
	fi
else
	touch "$name_of_file"
	echo "[global]" >> "$name_of_file"
	echo "node_count = $nodes" >> "$name_of_file"
	echo "book_size_bytes = $book_size" >> "$name_of_file"


	#Loop to write .ini file
	COUNTER=1
	index=0
	while true; do
		if [ "$COUNTER" -gt "9" ]; then
			echo "[node$COUNTER]" >>"$name_of_file"
		else
			echo "[node0$COUNTER]" >> "$name_of_file"
		fi
		echo "node_id = $COUNTER" >> "$name_of_file"
		echo "nvm_size = ${sizes[$index]}" >> "$name_of_file"
		if [ "$COUNTER" == "$nodes" ]; then
			break
		fi
		let COUNTER+=1
		let index+=1
	done
fi

tm-librarian/./book_register.py -d tm-librarian/"$db_file" "$name_of_file"
tm-librarian/./librarian.py --db_file tm-librarian/"$db_file" 
