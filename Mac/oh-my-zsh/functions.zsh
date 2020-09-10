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
