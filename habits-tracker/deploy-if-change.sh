echo "$(date --utc +%FT%TZ): Checking if there are any changes..." 

cd /etc/nixos/habits-tracker

export PULL_HABITS_TRACKER_SERVER_SPRING=$(docker pull shane3102/habits-tracker-server-spring)
export PULL_HABITS_TRACKER_SERVER_CUSTOM=$(docker pull shane3102/habits-tracker-server-custom)
export PULL_HABITS_TRACKER_SERVER_GATEWAY=$(docker pull shane3102/habits-tracker-server-gateway)

if [[ 
	$PULL_HABITS_TRACKER_SERVER_SPRING != *"Image is up to date"* ||
	$PULL_HABITS_TRACKER_SERVER_CUSTOM != *"Image is up to date"* ||
	$PULL_HABITS_TRACKER_SERVER_GATEWAY != *"Image is up to date"*
   ]]; then
   	echo "$(date --utc +%FT%TZ): Changes detected. Releasing new version..."
	sh manual-deploy.sh
else
   	echo "$(date --utc +%FT%TZ): No changes detected."
fi
