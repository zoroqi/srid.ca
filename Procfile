site: neuron rib -w
import: nix-shell -p inotify-tools --run "./import-private.sh; while inotifywait -qqre modify ~/Documents/zk/*; do ./import-private.sh; done"
