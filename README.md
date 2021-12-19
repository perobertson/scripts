# scripts

This repo is a collection of scripts that are handy for setting up a new pc.

[![pipeline status](https://gitlab.com/perobertson/scripts/badges/main/pipeline.svg)](https://gitlab.com/perobertson/scripts/pipelines?scope=branches&ref=main)

## Supported Operating Systems

Python is a main component of the tools that are installed and used.
Because of this, the scripts are designed to work with systems that have a python3 install that is still supported.

- Archlinux
- CentOS: stream8, stream9
- Debian: 10, 11
- Fedora: 34, 35
- Manjaro
- Ubuntu: 20.04(LTS), 21.04, 21.10

**Note:** OSes that are EOL, or are based on languages that are EOL are not tested in CI.

Checkout the [latest pipeline](https://gitlab.com/perobertson/scripts/pipelines?scope=branches&ref=main) for `main` to see the complete list of supported operating systems.

## Usage

To run the script, all you need to do is run this from a console on the machine that you are setting up.
This will checkout the project to `"${HOME}/Applications/scripts"` before applying other changes.

Using `curl`:

```bash
/usr/bin/curl -sSL https://gitlab.com/perobertson/scripts/raw/main/setup.sh | bash
```

Using `wget`:

```bash
/usr/bin/wget -qO- https://gitlab.com/perobertson/scripts/raw/main/setup.sh | bash
```

## Installing Extras

There are additional packages that can also be installed.
This is done though supplementary playbooks, each with their own make target.

- `make instal_docker`
- `make instal_gcloud`
- `make instal_kubernetes`
- `make instal_razer`

There are also additional rust crates that can be installed.

- `make install_rust_crates`

## Updating

The scripts are designed to be rerun to get the latest updates.

```bash
cd "${HOME}/Applications/scripts"
git pull --rebase
./setup.sh
```

You can also rerun the `curl` or `wget` commands from above.

## Adding new OS versions

To add a new OS version you need to add a build definition in `.gitlab-ci.yml`.
If this version requires specific install steps, you need to add a directory under the OS type and a `bootstrap.sh` file.
The `bootstrap.sh` script should only install `ansible`.
The rest of the setup script should be done as ansible tasks so that all systems benefit.
