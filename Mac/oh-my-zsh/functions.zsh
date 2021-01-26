###############################################
# Git
###############################################

# Git
function cleangbr()
{
	for mergedBranch in $(git for-each-ref --format '%(refname:short)' HEAD refs/heads/GN1*)
	do
	    git branch -D ${mergedBranch}
	done

	for mergedBranch in $(git for-each-ref --format '%(refname:short)' HEAD refs/heads/feature)
	do
	    git branch -D ${mergedBranch}
	done
}

function chgbr()
{
    if [[ -z "$1" ]]; then
		echo -e "\nUsage: chgbr <branch_name> or chgbr -all <branch_name>"
        git branch
	elif [[ -z "$2" ]]; then
    	declare -r branch="$1"
		echo -e "\nChanging git branch to '$branch' on $PWD"
		git fetch --all
		git stash save chgbrTemp
		git checkout $branch
	elif [[ "$1" = "-all" && ! -z "$2" ]]; then
		declare -r branch="$2"
		echo -e "\nChanging all available git branches to '$branch'"
		cd $G1_MICRO_ROOT/g1-common
		chgbr $branch
		cd $G1_MICRO_ROOT/g1-svc-api
		chgbr $branch
		cd $G1_MICRO_ROOT/g1-svc-catalog
		chgbr $branch
		cd $G1_MICRO_ROOT/g1-svc-management
		chgbr $branch
		cd $G1_MICRO_ROOT/g1-svc-customer
		chgbr $branch
		cd $G1_MICRO_ROOT/g1-svc-order
		chgbr $branch
		cd ..
		echo -e "\ndone"
	else
		echo -e "\nUsage: chgbr <branch_name> or chgbr -all <branch_name>"
		echo -e "Parameter usage: -all is the only acceptable parameter"
		git branch
	fi
}

function pullgbr()
{
    if [[ -z "$1" ]]; then
		echo -e "\nPulling remote changes into git branch on $PWD"
		git stash
		git pull
		git stash apply
	elif [[ "$1" = "-all" ]]; then
		echo -e "\nPulling remote changes into all available git branches"
		cd $G1_MICRO_ROOT/g1-common
		pullgbr
		cd $G1_MICRO_ROOT/g1-svc-api
		pullgbr
		cd $G1_MICRO_ROOT/g1-svc-catalog
		pullgbr
		cd $G1_MICRO_ROOT/g1-svc-management
		pullgbr
		cd $G1_MICRO_ROOT/g1-svc-customer
		pullgbr
		cd $G1_MICRO_ROOT/g1-svc-order
		pullgbr
		cd ..
		echo -e "\ndone"
	else
		echo -e "\nUsage: pullgbr or pullgbr -all"
		echo -e "Parameter usage: -all is the only acceptable parameter"
	fi
}

###############################################
# Other Functions
###############################################

#Batman
function batman()
{
	reload
	'clear'

	echo -e "																		 "
	echo -e "MMMMMMMMMMMMMMMMMMMMM.                             MMMMMMMMMMMMMMMMMMMMM"
	echo -e " .MMMMMMMMMMMMMMMMMMMM           M\  /M           MMMMMMMMMMMMMMMMMMMM. "
	echo -e "   .MMMMMMMMMMMMMMMMMMM          MMMMMM          MMMMMMMMMMMMMMMMMMM.   "
	echo -e "     MMMMMMMMMMMMMMMMMMM-_______MMMMMMMM_______-MMMMMMMMMMMMMMMMMMM     "
	echo -e "      MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM      "
	echo -e "      MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM      "
	echo -e "      MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM      "
	echo -e "     .MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.     "
	echo -e "    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    "
	echo -e "                   .MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM.                   "
	echo -e "                          .MMMMMMMMMMMMMMMMMM.                          "
	echo -e "                              .MMMMMMMMMM.                              "
	echo -e "                                 MMMMMM                                 "
	echo -e "                                  MMMM                                  "
	echo -e "                                   MM                                   "
	echo -e ""
	echo -e "True heroism is remarkably sober, very undramatic. It is not the urge to"
	echo -e "surpass all others at whatever cost, but the urge to serve others at whatever cost."
	echo -e ""
}

function hidden()
{
	if [ -z ${1+x} ]
	then
		echo -e "\nERROR: YOU MUST ENTER A FILEPATH";
		echo -r "Correct format: hidden <filepath>";
	else
		chflags hidden ${1:--ERROR}
	fi
}
