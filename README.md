# Pluto Notebook Environments
---- WIP ----
Deploy notebook servers to yr own binder instances in the cloud using: https://mybinder.org/.
Start by pasting the url of this repo to create an instance. Note that this is rather for sharing notebooks, a cloud solution can be found at https://juliahub.com
## Background
You can build a docker image using the Dockerfile in this directory. Push it to docker hub and change the ref in ./binder/ to roll yr own.
The same thing can be done a bit easier using https://juliahub.com/ui/Home, but this allows to build a custom environment (and potentially host websites, if something proves well).
### Notebooks

runScript.jl: run arb. python scripts with args

