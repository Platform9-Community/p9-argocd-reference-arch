set export

red := '\033[0;31m'
green := '\033[0;32m'
blue := '\033[0;34m'
cyan := '\033[0;36m'
no_color := '\033[0m'
####

_bash := "#!/usr/bin/env bash"

_sh := "just --no-highlight _exec_sh"

_default:
  @just --list --unsorted

_exec_sh *ARGS:
  @{{_bash}}
  {{ARGS}}

re-use src_cluster_name new_cluster_name:
  @{{_sh}} "printf \"\n\n{{cyan}}Copying site manifest {{src_cluster_name}}.yaml to {{new_cluster_name}}.yaml{{no_color}}\n\n\""
  @{{_sh}} "cp -f sites/{{src_cluster_name}}.yaml sites/{{new_cluster_name}}.yaml"
  @{{_sh}} "perl -p -i -e "s/{{src_cluster_name}}/{{new_cluster_name}}/g" sites/{{new_cluster_name}}.yaml"
  @{{_sh}} "printf \"\n{{green}}Done{{no_color}}\n\n\""

clone src_cluster_name new_cluster_name:
  @{{_sh}} "printf \"\n\n{{cyan}}Copying cluster manifest files from {{src_cluster_name}} to {{new_cluster_name}}{{no_color}}\n\n\""
  @{{_sh}} "cp -pr clusters/{{src_cluster_name}} clusters/{{new_cluster_name}}"
  @{{_sh}} "printf \"\n\n{{cyan}}Copying site manifest {{src_cluster_name}}.yaml to {{new_cluster_name}}.yaml{{no_color}}\n\n\""
  @{{_sh}} "cp -f sites/{{src_cluster_name}}.yaml sites/{{new_cluster_name}}.yaml"
  @{{_sh}} "perl -p -i -e "s/{{src_cluster_name}}/{{new_cluster_name}}/g" sites/{{new_cluster_name}}.yaml"
  @{{_sh}} "perl -p -i -e "s/{{src_cluster_name}}/{{new_cluster_name}}/g" clusters/{{new_cluster_name}}/README.md"
  @{{_sh}} "printf \"\n{{green}}Done{{no_color}}\n\n\""
