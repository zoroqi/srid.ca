site: neuron rib -w
import: nix-shell -p inotify-tools --run "while inotifywait -qqre modify ~/Documents/zk/*; do ./import-private.sh; done"