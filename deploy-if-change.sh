echo "$(date --utc +%FT%TZ): Checking if there are any changes..." 

cd /etc/nixos

export PULL_ILLCHESS_FRONTEND=$(docker pull shane3102/illchess-frontend)
export PULL_ILLCHESS_GATEWAY=$(docker pull shane3102/illchess-gateway)
export PULL_ILLCHESS_GAME_SERVICE=$(docker pull shane3102/illchess-game-service)
export PULL_ILLCHESS_STOCKFISH_SERVICE=$(docker pull shane3102/illchess-stockfish-service)
export PULL_ILLCHESS_PLAYER_INFO_SERVICE=$(docker pull shane3102/illchess-player-info-service)

if [[ 
	$PULL_ILLCHESS_FRONTEND != *"Image is up to date"* || 
	$PULL_ILLCHESS_GATEWAY != *"Image is up to date"* || 				
	$PULL_ILLCHESS_GAME_SERVICE != *"Image is up to date"* ||	
	$PULL_ILLCHESS_STOCKFISH_SERVICE != *"Image is up to date"* ||
	$PULL_ILLCHESS_PLAYER_INFO_SERVICE != *"Image is up to date"*
   ]]; then
   	echo "$(date --utc +%FT%TZ): Changes detected. Releasing new version..."
	sh manual-deploy.sh
else
   	echo "$(date --utc +%FT%TZ): No changes detected."
fi
