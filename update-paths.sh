# update absolute paths in package repository
find /modules/cs141/.stack/snapshots/x86_64-linux/lts-9.0/8.0.2/pkgdb/ -type f -name "*.conf" | xargs sed -i 's/\/dcs\/acad\/u1672682/\/modules\/cs141/g'
find /modules/cs141/.stack/snapshots/x86_64-linux/lts-12.14/8.4.3/pkgdb/ -type f -name "*.conf" | xargs sed -i 's/\/dcs\/acad\/u1672682/\/modules\/cs141/g'

# remove the existing package database
rm /modules/cs141/.stack/snapshots/x86_64-linux/lts-9.0/8.0.2/pkgdb/package.cache
rm /modules/cs141/.stack/snapshots/x86_64-linux/lts-12.14/8.4.3/pkgdb/package.cache

# rebuild the package database
stack exec --resolver=lts-9.0 -- ghc-pkg --package-db /modules/cs141/.stack/snapshots/x86_64-linux/lts-9.0/8.0.2/pkgdb/ recache
stack exec --resolver=lts-12.14 -- ghc-pkg --package-db /modules/cs141/.stack/snapshots/x86_64-linux/lts-12.14/8.4.3/pkgdb/ recache

# update permissions so that everyone can access the files
chmod -R o+rx /modules/cs141/.stack/
