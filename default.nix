let 
  # The commit hash of http://github.com/srid/neuron to use
  neuronRev = "2ea6d1b";
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
  gitRev = neuronRev;
}
