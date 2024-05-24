# ***********************************************
# * FURMAKE SECTION (DO NOT MODIFY)
# ***********************************************/

# $1 - search directory in parent directories
# Reverse search must be as portable as possible and work on most systems
function reverse_search #invoke as subshell
(
    prev=
    while [ "$(pwd)" != "$prev" ]; do
        if [ -d "$1" ]; then
            echo "$(cd "$1" && pwd)"
            break
        fi

        prev=$(pwd)
        cd ..
    done
)

# Find furmake directory
furmake_directory=$(reverse_search furmake)

if [ ! -d "$furmake_directory" ]; then
	echo "fatal: could not find furmake directory!"
	exit
fi

# Set a new environment variable
export FURMAKE_DIR=$(reverse_search furmake)

# Not yet ready
: '
furmake_script="${furmake_directory}/furmake.sh"

if [ ! -f "$furmake_script" ]; then
	echo "fatal: could not find furmake script!"
	exit
fi

source "${furmake_directory}/furmake.sh"
'

function furmake
{
	#import function
	if [ "$1" = "import" ]; then
		if [ "$3" != "as" ]; then
			echo "line" $(caller) "($@)"": missing 'as' token"
			exit
		fi
		if [ -z "$4" ]; then
			echo "line" $(caller) "($@)"": invalid object name"
			exit
		fi
	fi
}

# ***********************************************
# * USER SECTION (CHANGE WHATEVER YOU WANT)
# ***********************************************/
furmake import sp5055       as sp5055
furmake import simple_promt as spromt
