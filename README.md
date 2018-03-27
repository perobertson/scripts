# scripts

This repo is a collection of scripts that are handy for setting up a new pc.

To run the script, all you need to do is run this from a console on the machine that you are setting up.
```bash
/usr/bin/curl -sSL https://gitlab.com/perobertson/scripts/raw/master/setup.sh | time bash
```

For the users out there who prefer `wget`
```bash
/usr/bin/wget -qO- https://gitlab.com/perobertson/scripts/raw/master/setup.sh | time bash
```

## Adding new OS versions
To add a new OS version, just add a directory under the OS type with the version_id found in `/etc/os-release`
