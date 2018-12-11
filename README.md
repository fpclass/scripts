# Shell scripts for Haskell on DCS machines

These shell scripts are used to manage Haskell/Stack on the DCS machines.

## Installation

To install `haskell-setup.sh` and `update-path.sh` into `/modules/cs141/`, simply run the `install.sh` script:

```bash
./install.sh
```

This will copy both files to the shared location and set the correct permissions on `haskell-setup.sh` which enables students to run the script as well.

## Overview

Haskell Stack maintains sets of package versions which are known to be compatible with each other (snapshots), including a version of GHC that is compatible with them. By default, Stack stores snapshots in a user's home directory in a `~/.stack` folder. Unfortunately, this behaviour cannot be configured and therefore we have implemented the following workaround:

* The `/modules/cs141/.stack` folder contains a copy of the snapshots which are in use (currently `lts-9.0` for 17/18 and `lts-12.14` for 18/19)
* We create symbolic links from individual user's `~/.stack` folder to the respective folders in `/modules/cs141/.stack`
* Only users with write permissions to `/modules/cs141/.stack` can install packages

## Per-user installation

The `haskell-setup.sh` script creates the symbolic links from the current user's `~/.stack` directory to the `/modules/cs141/.stack` directory. This script only needs to be run once when the user first starts using Haskell/Stack on their account.

The script also performs other tasks, such as updating and installing Haskell-related Atom packages with `apm update` and `apm install`.

## Installing packages

Users who can write to `/modules/cs141/.stack` can install new packages as normal with `stack install` and other, similar commands. However, unfortunately, the Haskell package database files store absolute paths in them which means that we end up with a lot of files containing paths like `/dcs/acad/u1672682/.stack/` even though they are actually stored in `/modules/cs141/.stack/`. This would prevent other users from successfully building their projects with `stack build`.

The `update-paths.sh` script fixes this issue by replacing all occurrences of `/dcs/acad/u1672682/` with `/modules/cs141/` in the `.conf` files in the package database (such as in e.g. `/modules/cs141/.stack/snapshots/x86_64-linux/lts-12.14/8.4.3/pkgdb/` for `lts-12.14` using GHC version `8.4.3`). If another user were to install packages, the script would have to modified accordingly. This script _must_ be run every time a new package is installed.

The script also sets the permissions on the `/modules/cs141/.stack` folder so that students can read the files.
