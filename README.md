# scripts

This repo is a collection of scripts that are handy for setting up a new pc.

[![pipeline status](https://gitlab.com/perobertson/scripts/badges/main/pipeline.svg)](https://gitlab.com/perobertson/scripts/pipelines?scope=branches&ref=main)

## Supported Operating Systems

Python3 is a main component of the tools that are installed and used. This
limits which OS versions that are supported since Python2 is EOL. In general,
this list will be the latest LTS release, and one fast release for the
distribution. OSes that become EOL or use EOL languages can still be run as
manual jobs in the CI pipeline and will be cleaned up after a period of time.

- Archlinux
- CentOS: stream9
- Debian: 11
- Fedora: 36, 37
- Manjaro
- Ubuntu: 22.04(LTS), 22.10

Please see the [latest pipeline] for `main` for the complete list.

[latest pipeline]: https://gitlab.com/perobertson/scripts/pipelines?scope=branches&ref=main

## Usage

To run the script, all you need to do is run this from a console on the machine that you are setting up.
This will checkout the project to `"${CODE_PATH:-~/workspace}/perobertson/scripts"` before applying other changes.

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
This is done though supplementary playbooks, or script.
They can be invoked through tasks.
Run `go-task -a` to see the full list.

## Updating

The scripts are designed to be rerun to get the latest updates.

```bash
cd "${CODE_PATH:-~/workspace}/perobertson/scripts"
git pull --rebase
./setup.sh
```

You can also rerun the `curl` or `wget` commands from above.

## Adding new OS versions

To add a new OS version you need to add a build definition in `.gitlab-ci.yml`.
If this version requires specific install steps, you need to add a directory under the OS type and a `bootstrap.sh` file.
The `bootstrap.sh` script should only install `ansible`.
The rest of the setup script should be done as ansible tasks so that all systems benefit.

## Keybindings

This is a non exhaustive list of the keybindings that have been configured.

### Desktop environments

**Cinnamon:**

- `<Shift><Super>exclam` will toggle 1Password
- `<Primary><Shift>space` will toggle 1Password quick access
    - primary is ctrl
