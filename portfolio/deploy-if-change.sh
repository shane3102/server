echo "$(date --utc +%FT%TZ): Checking if there are any changes..." 

cd /etc/nixos/portfolio

export PULL_ILLCHESS_FRONTEND=$(docker pull shane3102/portfolio)

if [[ $PULL_ILLCHESS_FRONTEND != *"Image is up to date"* ]]; then
   	echo "$(date --utc +%FT%TZ): Changes detected. Releasing new version..."
	sh manual-deploy.sh
else
   	echo "$(date --utc +%FT%TZ): No changes detected."
fi
