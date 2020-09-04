# scripts

This repo is a collection of scripts that are handy for setting up a new pc.

[![pipeline status](https://gitlab.com/perobertson/scripts/badges/main/pipeline.svg)](https://gitlab.com/perobertson/scripts/commits/main)

## Supported Operating Systems

Python is a main component of the tools that are installed and used.
Because of this, the scripts are designed to work with systems that have a python3 install that is still supported.

- Archlinux
- CentOS: 8
- Fedora: 28(EOL), 29 (EOL), 30 (EOL), 31, 32
- Manjaro
- Ubuntu: 18.04, 20.04

Checkout the [latest pipeline](https://gitlab.com/perobertson/scripts/pipelines?scope=branches) for `main` to see the complete list of supported operating systems.

## Usage

To run the script, all you need to do is run this from a console on the machine that you are setting up.

Using `curl`:

```bash
/usr/bin/curl -sSL https://gitlab.com/perobertson/scripts/raw/main/setup.sh | time bash
```

Using `wget`:

```bash
/usr/bin/wget -qO- https://gitlab.com/perobertson/scripts/raw/main/setup.sh | time bash
```

## Adding new OS versions

To add a new OS version you need to add a build definition in `.gitlab-ci.yml`.
If this version requires specific install steps, you need to add a directory under the OS type and a `bootstrap.sh` file.
The `bootstrap.sh` script should only install `ansible`.
The rest of the setup script should be done as ansible tasks so that all systems benefit.
