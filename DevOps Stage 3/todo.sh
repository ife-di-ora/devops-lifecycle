#!/bin/bash

TODO_FILE="$HOME/todo.txt"

#create todo file if it does not exist

touch "$TODO_FILE"

while true 
do
	echo "==================="
	echo "|   TO DO LIST    |"
	echo "==================+"
	echo "1. View all tasks"
	echo "2. Add a new task"
	echo "3. Delete a task"
	echo "4. Exit"
	echo "==================="

	read -p "Select an option:	" choice

	case $choice in 
		1)
			echo "Tasks List: "
			if [ -s "$TODO_FILE" ]; then
				nl -w2 -s'. ' "$TODO_FILE"
			else
				echo "No tasks found"
			fi
			;;

		2)
			read -p "add new task:	" task
			echo ""
			echo "$task" >> "$TODO_FILE"
			echo "Task added successfully!"
			echo ""
			;;
		3)
			if [ ! -s "$TODO_FILE" ]; then 
				echo "No tasks availbale"
			else
				echo "List of current tasks:"
				echo ""
				nl -w2 -s'. ' "$TODO_FILE"

				read -p "Enter Serial Number of task to delete:	" task_num
				echo ""
				sed -i "${task_num}d" "$TODO_FILE"
				echo "task deleted"
			fi
			;;
		4)	echo "exiting..."
			exit 0
			;;
		*)	echo "Invalid Option"
			;;
	esac
done
