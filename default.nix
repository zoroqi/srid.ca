let 
  # The commit hash of http://github.com/srid/neuron to use
  neuronRev = "e518174";
in {
  neuron ? builtins.fetchTarball "https://github.com/srid/neuron/archive/${neuronRev}.tar.gz"
# Cabal project root
, root ? ./.
# Cabal project name
, name ? "sridca"
, ...
}:

let 
  fetchGH = repo: rev: builtins.fetchTarball "https://github.com/${repo}/archive/${rev}.tar.gz";
  source-overrides = {
  };
in import neuron { 
  inherit root name source-overrides; 
}
