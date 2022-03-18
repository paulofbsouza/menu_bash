#########################################################################
# Script Name: 'script menu.sh'
# Matrix College - Final project
# Fall 2021/Winter 2022
# Owner: Team 2 [ Paulo | Ivan | Carlos | Gurkirat | Camilo ]
# Description: Script for generate, check file, transmit and create a transmission log
# Changes: (1) Created a menu with options (2) Create a title to the file.txt (3) Menu improvements (4) Fixed the destination file and adapted the Option #6 using tail instead of cat command. 
#######################################################################

echo "*******"
echo "Matrix College - 2022"
echo "Linux Course"
echo "This is the Team-2 Script Menu"
echo "*******"
echo " "

PS3="Chose an Option: "
options=(
        "Create a file"
        "File information - File command"
        "File information - Cksum command"
        "File content - Cat command"
        "File transmission"
        "Log file content"
        "Exit"
)
select opt in "${options[@]}"
do
        case $opt in
                "Create a file")
                        echo "You chose the Option #1"
                        echo "Generating the file_to_copy.txt ....."
                        echo "UID|USER" > file_to_copy.txt
                        awk -F : '{if (NR>1) {printf "%s|%s\n",$3,$1}}' /etc/passwd >> file_to_copy.txt
                        echo "File created successfully!"
                        echo " "
                        ;;
                "File information - File command")
                        echo "You chose the option #2"
                        echo "Checking file information....."
                        echo "File information:"
                        file file_to_copy.txt
                        echo " "
                        ;;
                "File information - Cksum command")
                        echo "You chose the option #3"
                        echo "Checking the cksum and counting the bytes in the file....."
                        cksum file_to_copy.txt
                        echo " "
                        ;;
                "File content - Cat command")
                        echo "You chose the option #4"
                        echo "Checking 'file_to_copy.txt' content....."
                        cat file_to_copy.txt | more
                        echo " "
                        ;;
                "File transmission")
                        echo "You chose the option #5"
                        echo "Testing connection.........."
                        echo "File transmission started..."
                        echo "`date +"%Y-%m-%d-%H-%M"`"-$HOME/file_to_copy.txt >> file_to_copy.log
                        echo " "
                        echo "Please, wait..."
                        script -q -c "scp -v file_to_copy.txt server:/tmp" >> file_to_copy.log
                        echo " "
                        echo "Transmission finished!"
                        echo "Please, check the .log file to know more about the status!"
                        echo " "
                        ;;
                "Log file content")
                        echo "You chose the option #6"
                        echo "Checking the transmission log content...."
                        tail -68 file_to_copy.log | more
                        echo " "
                        ;;
                "Exit")
                        break
                        ;;
                *)
                echo "Invalid option, please try again!"
                ;;
        esac
done
