# scripts

This repo is a collection of scripts that are handy for setting up a new pc.

[![pipeline status](https://gitlab.com/perobertson/scripts/badges/master/pipeline.svg)](https://gitlab.com/perobertson/scripts/commits/master)

Supported Operating Systems:
- Fedora 25 (Deprecated)
- Fedora 26 (Deprecated)
- Fedora 27 (Deprecated)
- Fedora 28
- Fedora 29

Checkout the [latest pipeline](https://gitlab.com/perobertson/scripts/pipelines?scope=branches) for `master` to see the complete list of supported operating systems.


To run the script, all you need to do is run this from a console on the machine that you are setting up.
```bash
/usr/bin/curl -sSL https://gitlab.com/perobertson/scripts/raw/master/setup.sh | time bash
```

For the users out there who prefer `wget`
```bash
/usr/bin/wget -qO- https://gitlab.com/perobertson/scripts/raw/master/setup.sh | time bash
```

## Adding new OS versions
To add a new OS version you need to add a build definition in `.gitlab-ci.yml`.
If this version requires specific install steps, you need to add a directory under the OS type with the version_id found in `/etc/os-release`
