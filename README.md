## Terraform Setup

`terraform init` downloads providers separately for each project.
Plugins can get quite large - and we can cache them by setting an environment variable on the machine:

```bash
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
``` 

