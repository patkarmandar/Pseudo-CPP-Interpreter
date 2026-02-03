#!/bin/bash

# Source: https://github.com/patkarmandar/Pseudo-CPP-Interpreter
# Author: @patkarmandar (https://patkarmandar.github.io/)
# License: GPL-3.0

code(){
	while read line; do
		echo $line
	done < file
}

run(){
	read -p ">> " cmd

	case $cmd in
		help)
			echo "Pseudo C++ Interpreter"
			echo -e "Type \"clear\" to clear the screen, \"reset\" to reset the code, \"cpp <file>\" to execute the C++ file, \"exit\" to exit the interpreter, \"help\" to display this information."
			return 0;
			;;
		clear)
		    clear
			return 0
		    ;;
		reset)
		    rm -f file code.cpp a.out
			clear
			return 0
		    ;;
		exit)
		    rm -f file code.cpp a.out
			exit 0
		    ;;
		cpp*)
			fname=$(echo ${cmd/cpp/})
			g++ $fname && ./a.out
			return 0
			;;
		cin*)
			echo -e "Error: \"cin\" is not working...!"
			return 0
			;;
		*)
		    echo $cmd >> file
		    echo -e "#include<bits/stdc++.h>\nusing namespace std;\nint main(){\n$(code)\nreturn 0;\n}" > code.cpp
		    ;;
	esac

	g++ code.cpp && ./a.out

	if [[ $? != 0 ]]; then
		sed -i "s/${cmd}/\/\/${cmd}/g" file
	fi

	if [[ "$cmd" =~ "cout" ]]; then
		sed -i "s/${cmd}/\/\/${cmd}/g" file
	fi
}

echo "Pseudo C++ Interpreter"
echo -e "Type \"clear\" to clear the screen, \"reset\" to reset the code, \"cpp <file>\" to execute the C++ file, \"exit\" to exit the interpreter, \"help\" to display this information."
touch file

while true; do
	run
done
