let 
  # The commit hash of http://github.com/srid/neuron to use
  neuronRev = "53cbd619d13699335e2011f928265d8d172c6048";
in {
  neuron ? ../neuron # builtins.fetchTarball "https://github.com/srid/neuron/archive/${neuronRev}.tar.gz"
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
