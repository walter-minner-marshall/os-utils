# Reload
alias reload='source ~/.bash_profile'

# Variables
G1_MAIN_ROOT='C:\\G1\\g1-main\\'
G1_MAIN_PRESENTATION='C:\\G1\\g1-main\\G1_Baseline\\src\\SpaFinder.SpaBooker\\Presentation\\SpaFinder.SpaBooker.WebApps.Admin\\'
G1_MICRO_ROOT='C:\\G1\\g1-svc-micro\\'
G1_LEGACY_ROOT='C:\\G1\\g1-svc-legacypayments\\'

USER_ROOT='C:\\Users\\a206505611'
USER_DATA_ROOT='C:\\Users\\a206505611\\UserData'
G1_DB_ROOT='//Mac/AllFiles/Users/a206505611/Dev/G1/g1-database'
MAC_ROOT='//Mac/AllFiles'

alias db="cd $G1_DB_ROOT"
alias userdata="cd $USER_DATA_ROOT"

# Bash
alias fhere="find . -name "
alias ps="ps auxf"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"

#-------------------
# NuGet Aliases
#-------------------

alias nugetpack="echo 'nuget pack <PROJECT> -IncludeReferencedProjects -properties Configuration=Release -Version <SPRINT>'"
alias nugetpush="echo 'nuget push <PACKAGE> -Source GolfNow <API KEY>'"

#-------------------
# Development Paths
#-------------------

alias main="cd $G1_MAIN_ROOT"
alias billableitem="cd '$G1_MAIN_ROOT\\G1_Api\\src\\G1.Services.BillableItem.API\\Client\\G1.Services.WebApi.Client'"
alias presentation=" cd $G1_MAIN_PRESENTATION"
alias pres=" cd $G1_MAIN_PRESENTATION"
alias micro="cd $G1_MICRO_ROOT"
alias legacy="cd $G1_LEGACY_ROOT"

#-------------------
# Personnal Aliases
#-------------------

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
# -> Prevents accidentally clobbering files.
alias mkdir='mkdir -p'

alias h='history'
alias j='jobs -l'
alias which='type -a'
alias ..='cd ..'
alias cd..='cd ..'

# Pretty-print of some PATH variables:
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

alias du='du -kh'    # Makes a more readable output.
alias df='df -kTh'
alias sizedir='du -sh ./*'

# Applications
alias editbash="nano '$USER_ROOT\\.bash_profile'"
alias nginx="'C:\\nginx\\nginx.exe'"

alias pass="cat '$USER_DATA_ROOT\\passwords.js'"
alias editpass="nano '$USER_DATA_ROOT\\passwords.js'"

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls).
#-------------------------------------------------------------

# Add colors for filetype and  human-readable sizes by default on 'ls':
alias ls='ls -h --color'
alias lx='ls -lXB'         #  Sort by extension.
alias lk='ls -lSr'         #  Sort by size, biggest last.
alias lt='ls -ltr'         #  Sort by date, most recent last.
alias lc='ls -ltcr'        #  Sort by/show change time,most recent last.
alias lu='ls -ltur'        #  Sort by/show access time,most recent last.

# The ubiquitous 'll': directories first, with alphanumeric sorting:
alias ll="ls -lv --group-directories-first"
alias lm='ll |more'        #  Pipe through 'more'
alias lr='ll -R'           #  Recursive ls.
alias la='ll -A'           #  Show hidden files.
alias tree='tree -Csuh'    #  Nice alternative to 'recursive ls' ...

# Miscellaneous
alias wget="wget -c"
alias top="htop"

# Grep
alias grep='grep -n'
unset GREP_OPTIONS
export GREP_COLOR='1;35;40'

#-------------------------------------------------------------
# The 'git' family (this assumes you have git installed)
#-------------------------------------------------------------

# Patch
alias papply="git apply"
alias gdiff="git diff --ignore-space-at-eol -b -w --ignore-blank-lines"

alias g1strings="git apply --reject --whitespace=nowarn --unsafe-paths --directory='C:/G1/g1-main/' 'C:\\G1\\g1_connectionStrings.patch'"
alias sg1strings="gdiff > 'C:\\G1\\g1_connectionStrings.patch'"

alias pacb="git apply 'C:\\G1\\accountBalanceBRS.patch'"
alias sacb="gdiff > 'C:\\G1\\accountBalanceBRS.patch'"

alias pmem="git apply --reject --whitespace=nowarn --unsafe-paths --directory='C:/G1/g1-main/' 'C:\\G1\\membershipBRS.patch'"
alias smem="gdiff > 'C:\\G1\\membershipBRS.patch'"

alias sapistrings="gdiff > '$G1_MICRO_ROOT\\api_connectionStrings.patch'"
alias scatstrings="gdiff > '$G1_MICRO_ROOT\\catalog_connectionStrings.patch'"
alias smanstrings="gdiff > '$G1_MICRO_ROOT\\management_connectionStrings.patch'"
alias scusstrings="gdiff > '$G1_MICRO_ROOT\\customer_connectionStrings.patch'"
alias sordstrings="gdiff > '$G1_MICRO_ROOT\\order_connectionStrings.patch'"

# Branch
alias delbranch="git branch -D"

#-------------------------------------------------------------
# NPM
#-------------------------------------------------------------
alias g1npm="cd $G1_MAIN_PRESENTATION && npm i && cd -"


#-------------------------------------------------------------
# Functions
#-------------------------------------------------------------
#-------------------
# Custom Functions
#-------------------
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
		cd $G1_MAIN_ROOT
		chgbr $branch
		cd $G1_MICRO_ROOT\\g1-common
		chgbr $branch
		cd $G1_MICRO_ROOT\\g1-svc-api
		chgbr $branch
		cd $G1_MICRO_ROOT\\g1-svc-catalog
		chgbr $branch
		cd $G1_MICRO_ROOT\\g1-svc-management
		chgbr $branch
		cd $G1_MICRO_ROOT\\g1-svc-customer
		chgbr $branch
		cd $G1_MICRO_ROOT\\g1-svc-order
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
		git pull
	elif [[ "$1" = "-all" ]]; then
		echo -e "\nPulling remote changes into all available git branches"
		cd $G1_MAIN_ROOT
		pullgbr
		cd $G1_MICRO_ROOT\\g1-common
		pullgbr
		cd $G1_MICRO_ROOT\\g1-svc-api
		pullgbr
		cd $G1_MICRO_ROOT\\g1-svc-catalog
		pullgbr
		cd $G1_MICRO_ROOT\\g1-svc-management
		pullgbr
		cd $G1_MICRO_ROOT\\g1-svc-customer
		pullgbr
		cd $G1_MICRO_ROOT\\g1-svc-order
		pullgbr
		cd ..
		echo -e "\ndone"
	else
		echo -e "\nUsage: pullgbr or pullgbr -all"
		echo -e "Parameter usage: -all is the only acceptable parameter"
	fi
}

function papistrings()
{
	local apiPath='C:/G1/g1-svc-micro/g1-svc-api/'
	local apiPatchPath="$G1_MICRO_ROOT\\api_connectionStrings.patch"
	git apply --reject --ignore-space-change --ignore-whitespace --unsafe-paths --directory=$apiPath $apiPatchPath
}
function pcatstrings()
{
	local catalogPath='C:/G1/g1-svc-micro/g1-svc-catalog/'
	local catalogPatchPath="$G1_MICRO_ROOT\\catalog_connectionStrings.patch"
	git apply --reject --ignore-space-change --ignore-whitespace --unsafe-paths --directory=$catalogPath $catalogPatchPath
}
function pmanstrings()
{
	local managementPath='C:/G1/g1-svc-micro/g1-svc-management/'
	local managementPatchPath="$G1_MICRO_ROOT\\management_connectionStrings.patch"
	git apply --reject --ignore-space-change --ignore-whitespace --unsafe-paths --directory=$managementPath $managementPatchPath
}
function pcusstrings()
{
	local customerPath='C:/G1/g1-svc-micro/g1-svc-customer/'
	local customerPatchPath="$G1_MICRO_ROOT\\customer_connectionStrings.patch"
	git apply --reject --ignore-space-change --ignore-whitespace --unsafe-paths --directory=$customerPath $customerPatchPath
}
function pordstrings()
{
	local orderPath='C:/G1/g1-svc-micro/g1-svc-order/'
	local orderPatchPath="$G1_MICRO_ROOT\\order_connectionStrings.patch"
	git apply --reject --ignore-space-change --ignore-whitespace --unsafe-paths --directory=$orderPath $orderPatchPath	
}
function psvcstrings()
{
	papistrings
	pcatstrings
	pmanstrings
	pcusstrings
	pordstrings
}

function stash()
{
    if [ "$1" = "view" ]; then
        git stash show stash@{$2}

    elif [ "$1" = "show" ]; then
        git stash show -p stash@{$2}

    elif [ "$1" = "save" ]; then
        git stash save -u "`date +'%m/%d/%Y %r'` - $2"

    elif [ "$1" = "pop" ]; then
        git stash pop stash@{$2}

    elif [ "$1" = "apply" ]; then
        git stash apply stash@{$2}

    elif [ "$1" = "list" ]; then
        git stash list

    elif [ "$1" = "drop" ]; then
        git stash drop stash@{$2}

    elif [ "$1" = "checkpoint" ]; then
    git stash save -u "`date +'%m/%d/%Y %r'` [Checkpoint] - $2" && git stash apply stash@{0}

    fi
}

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

function hotfix()
{
	echo -e "\ngit checkout -b <hotfixname> <tagnumber>"
}

# Clean G1
function cleang1()
{
	local binPath='$G1_MAIN_PRESENTATION\bin\'
	local objPath='$G1_MAIN_PRESENTATION\obj\'
	rm -rf $binPath
	rm -rf $objPath
}

# Purge Spas From Database
function purge()
{
  local dbName='GolfNowOne'
  local scriptPath="$USER_DATA_ROOT\run_spa_purge.sql"
  sqlcmd -d $dbName -E -i $scriptPath -e -r -m 1
}

# Create Snapshot From Database
function csnap()
{
  local dbName='GolfNowOne'
  local scriptPath="$USER_DATA_ROOT\create_snapshot.sql"
  sqlcmd -d $dbName -E -i $scriptPath -e -r -m 1
}

# Restore Database From Snapshot
function rsnap()
{
  local dbName='GolfNowOne'
  local scriptPath="$USER_DATA_ROOT\restore_snapshot.sql"
  sqlcmd -d $dbName -E -i $scriptPath -e -r -m 1	
}

# Delete Snapshot From Database
function dsnap()
{
  local dbName='GolfNowOne'
  local scriptPath="$USER_DATA_ROOT\delete_snapshot.sql"
  sqlcmd -d $dbName -E -i $scriptPath -e -r -m 1
}

#-------------------
# Personal Functions
#-------------------
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
	echo -e "True heroism is remarkably sober, very undramatic. It is not the urge to"
	echo -e "surpass all others at whatever cost, but the urge to serve others at whatever cost."
}

#Machine information functions
function mach()
{
    echo -e "\nMachine information:" ; uname -a
    echo -e "\nCurrent date :" ; date
    echo -e "\nFilesystem status :"; df -h
}
