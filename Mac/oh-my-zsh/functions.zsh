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


function existgbr()
{
    if [[ -z "$1" ]]; then
		echo -e "\nUsage: existgbr <branch_name> or existgbr -all <branch_name>"
	elif [[ -z "$2" ]]; then
    	declare -r branch="$1"
		echo -e "\nChecking for git remote branch with name '$branch' on $PWD"
		git ls-remote --heads origin | egrep refs/heads/$branch
	elif [[ "$1" = "-all" && ! -z "$2" ]]; then
		declare -r branch="$2"
		echo -e "\nChecking all available repos for git branches with name '$branch'"
		echo -e "g1-main"
		git ls-remote --heads git@github.com:/GolfNowEng/g1-main.git | egrep refs/heads/$branch
		echo -e "g1-database"
		git ls-remote --heads git@github.com:/GolfNowEng/g1-database.git | egrep refs/heads/$branch		
		echo -e "g1-common"
		git ls-remote --heads git@github.com:/GolfNowEng/g1-common.git | egrep refs/heads/$branch
		echo -e "g1-svc-api"
		git ls-remote --heads git@github.com:/GolfNowEng/g1-svc-api.git | egrep refs/heads/$branch
		echo -e "g1-svc-catalog"
		git ls-remote --heads git@github.com:/GolfNowEng/g1-svc-catalog.git | egrep refs/heads/$branch
		echo -e "g1-svc-management"
		git ls-remote --heads git@github.com:/GolfNowEng/g1-svc-management.git | egrep refs/heads/$branch
		echo -e "g1-svc-customer"
		git ls-remote --heads git@github.com:/GolfNowEng/g1-svc-customer.git | egrep refs/heads/$branch
		echo -e "g1-svc-order"
		git ls-remote --heads git@github.com:/GolfNowEng/g1-svc-order.git | egrep refs/heads/$branch
		echo -e "g1-svc-kds"
		git ls-remote --heads git@github.com:/GolfNowEng/g1-svc-kds.git | egrep refs/heads/$branch	
		echo -e "g1-svc-report"
		git ls-remote --heads git@github.com:/GolfNowEng/g1-svc-report.git | egrep refs/heads/$branch			
		echo -e "g1-svc-membership"
		git ls-remote --heads git@github.com:/GolfNowEng/g1-svc-membership.git | egrep refs/heads/$branch			
		echo -e "\ndone"
	else
		echo -e "\nUsage: existgbr <branch_name> or existgbr -all <branch_name>"
		echo -e "Parameter usage: -all is the only acceptable parameter"
	fi	
}

###############################################
# OpenAPI
# Need to install
## python3
## pip3 install requests
# oasdiff
###############################################
function gencl()
{
	python3 ~/Dev/os-utils/Mac/download_ticketingapi_swags.py
	oasdiff changelog -f html ticketing_gatewayapi.stage.json ticketing_gatewayapi.dev.json > ticketing_gatewayapi_changelog.html
}


###############################################
# Other Functions
###############################################

#Cross
function cross()
{
	reload
	'clear'

	echo -e "						✞✞✞										                 "
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

# Speed test via macOS built-in networkQuality; pretty output
speedtest() {
  command -v networkQuality >/dev/null || { print -P "%F{red}networkQuality not found (needs macOS 12+)%f"; return 1; }
  command -v jq >/dev/null || { print -P "%F{red}jq required%f"; return 1; }
  print -P "%F{cyan}Running speed test...%f"
  local json
  json=$(networkQuality -c -M "${1:-15}" 2>/dev/null) || { print -P "%F{red}Test failed%f"; return 1; }

  local dl ul rtt rpm_dl rpm_ul iface
  dl=$(jq -r '(.dl_throughput // 0) / 1000000' <<<"$json")
  ul=$(jq -r '(.ul_throughput // 0) / 1000000' <<<"$json")
  rtt=$(jq -r '.base_rtt // 0' <<<"$json")
  rpm_dl=$(jq -r '.dl_responsiveness // .responsiveness // 0' <<<"$json")
  rpm_ul=$(jq -r '.ul_responsiveness // .responsiveness // 0' <<<"$json")
  iface=$(jq -r '.interface_name // "?"' <<<"$json")

  _st_bar() { # value max -> 30-wide bar
    local n=$(( ${1%.*} * 30 / $2 )); (( n > 30 )) && n=30; (( n < 0 )) && n=0
    printf '%s%s' "${(l:$n::█:)}" "${(l:$((30-n))::░:)}"
  }
  _st_rating() { # rpm -> label
    local r=${1%.*}
    if (( r >= 1000 )); then print -n "%F{green}High%f"
    elif (( r >= 300 )); then print -n "%F{yellow}Medium%f"
    else print -n "%F{red}Low%f"; fi
  }

  print
  print -P "%B%F{blue}╭──────────────────────────────────────────────╮%f%b"
  print -P "%B%F{blue}│%f          %BSPEED TEST%b  %F{8}($iface)%f"
  print -P "%B%F{blue}╰──────────────────────────────────────────────╯%f%b"
  printf '\n'
  print -P "  %F{green}⬇  Download%f  %B$(printf '%8.1f' $dl)%b Mbps  %F{green}$(_st_bar $dl 1000)%f"
  print -P "  %F{magenta}⬆  Upload  %f  %B$(printf '%8.1f' $ul)%b Mbps  %F{magenta}$(_st_bar $ul 1000)%f"
  print -P "  %F{yellow}⏱  Latency %f  %B$(printf '%8.1f' $rtt)%b ms"
  print -P "  %F{cyan}⚡ Responsiveness%f  ↓ $(printf '%.0f' $rpm_dl) RPM $(_st_rating $rpm_dl)   ↑ $(printf '%.0f' $rpm_ul) RPM $(_st_rating $rpm_ul)"
  print
  unfunction _st_bar _st_rating
}
