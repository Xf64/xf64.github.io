#!/bin/sh

sh inserttable.sh score.html "$GAMES/games.txt" "<!--all_games-->" "<!--all_games_end-->"
sh inserttable.sh score.html "$DOCS/th/thc.csv" "<!--th-->" "<!--th_end-->"
sh inserttable.sh score.html "$DOCS/th/ufo/score/ufo_runs.csv" "<!--ufo-->" "<!--ufo_end-->"
