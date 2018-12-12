# Shell scripts for Haskell on DCS machines

These shell scripts are used to manage Haskell/Stack on the DCS machines.

## Installation

To install `haskell-setup.sh` and `update-path.sh` into `/modules/cs141/`, simply run the `install.sh` script:

```bash
$ ./install.sh
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

## haskell-ide-engine

The [haskell-ide-engine](https://github.com/haskell/haskell-ide-engine) (`hie`) tool is a wrapper around various Haskell tools, including GHC, which implements the [Language Server Protocol](https://microsoft.github.io/language-server-protocol/specification) (LSP). This tool can then be used with various editor plugins, such as `ide-haskell-hie` for Atom.

The `hie` tool depends on some pinned/custom versions of Haskell packages in order to build successfully. Following the installation instructions in the README of `hie`, we can obtain its source code and that of its dependencies by cloning it off GitHub. On the DCS machines, we need to ensure that we build the program in a shared location because some libraries will be stored in the `.stack-work` folder relative to the project root that will be _hardcoded_ into the `hie` binary:

```bash
$ cd /modules/cs141
$ git clone https://github.com/haskell/haskell-ide-engine --recursive
$ cd haskell-ide-engine
```  

We need to install Cabal as well with the following commands (make sure to specify an appropriate resolver for `stack`):

```bash
$ stack install cabal-install --resolver=lts-12.14
# at this point, ensure that the installed cabal is in $PATH
# or copy it there first
$ cabal update
$ cabal install Cabal-2.4.1.0 --with-compiler=`stack path --resolver=lts-12.14 --compiler-exe`
```

We probably do not want to build `hie` for all versions of GHC it supports. Instead, we can build it for the versions of GHC we want by specifying which configuration for `stack` to use. We also need to specify a value for the `cabal_helper_libexecdir` environment variable.

```bash
$ export cabal_helper_libexecdir=/modules/cs141/bin
$ stack build --stack-yaml=stack-8.4.3.yaml
```

The above command will build `hie` for GHC 8.4.3 (used by `lts-12.14`).

To install `hie`, we then need to run (making sure to specify an appropriate value for `--local-bin-path`):

```bash
$ stack install --local-bin-path=/modules/cs141/bin/ --stack-yaml=stack-8.4.3.yaml
```

At this point, `hie` will be installed to `/modules/cs141/bin`. Ensure that the permissions are set correctly.

Unfortunately, `hie` will likely not work straight away for users other than the one who built it. There are a couple of extra paths that need to be symlinked (`haskell-setup.sh` should take care of that now):

* `hie` depends transitively on `cabal-helper-wrapper`, which does not like living in the `stack` ecosystem, see the [linked discussion](https://github.com/haskell/haskell-ide-engine/issues/483). To address this, we need to map `~/.cabal` to a shared location which has the `Cabal` package installed. This is now done by `haskell-setup.sh` which maps it to `/modules/cs141/.cabal`

* Note that Cabal's `config` file contains a number of absolute paths that need to be patched to the right ones for the shared location.

* `hie` also seems to depend on access to a `~/.cache/cabal-helper` directory which contains the `cabal-helper` executable. I am not sure why this executable ends up in this location rather than one of the usual ones, but `hie` seems to depend on it and putting it there with the right permissions seems to enable it to work correctly. The `haskell-setup.sh` script now also maps `~/.cache/cabal-helper` to `/modules/cs141/.cache/cabal-helper`
