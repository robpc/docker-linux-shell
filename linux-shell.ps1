$env_file = $PSScriptRoot + "/config.env"
docker run -v ${HOME}:/home/host -v ${pwd}:/cwd --env-file $env_file --rm -i -t linux-shell