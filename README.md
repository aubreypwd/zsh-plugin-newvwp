# `newvwp`

Spins up a new WordPress site using Valet. 

If you run this in an un-parked directory, it will prompt you to park the directory. It will then create the directory, install WordPress, setup constants for you, and optionally install `spatie/ray` and `debug-bar-*` plugins for you.

## Constants

These constants are set during setup and are not customizable at the moment, just edit `wp-config.php` and make your changes there.

```
BP_DEFAULT_COMPONENT 'staging-area'
BP_XPROFILE_SLUG 'staging-area'
COMPRESS_CSS false 
COMPRESS_SCRIPTS false 
CONCATENATE_SCRIPTS false 
DISABLE_WP_CRON true 
EMPTY_TRASH_DAYS 0 
ENFORCE_GZIP false 
EP_DASHBOARD_SYNC false 
EP_HOST 'http://failed.tld/'
FORCE_SSL_ADMIN true 
FORCE_SSL_LOGIN true 
FS_CHMOD_DIR 0775 
FS_CHMOD_FILE 0664 
FS_METHOD direct
FS_METHOD direct 
JETPACK_DEV_DEBUG true 
SAVE_QUERIES true 
SCRIPT_DEBUG true 
WP_AUTO_UPDATE_CORE false 
WP_CACHE false 
WP_DEBUG true 
WP_DEBUG_DISPLAY false 
WP_DEBUG_LOG true 
WP_ENVIRONMENT_TYPE 'local'
WP_LOCAL_DEV true 
WP_MAX_MEMORY_LIMIT 4096
WP_MEMORY_LIMIT 4096
```

To set these in any install, use the included command `set-debug-constants`.

## Debug Bar & Development plugins (`--debug-bar`)

- `debug-bar`
- `debug-bar-console`
- `debug-bar-shortcodes`
- `debug-bar-constants`
- `debug-bar-post-types`
- `debug-bar-cron`
- `debug-bar-actions-and-filters-addon`
- `debug-bar-transients`
- `debug-bar-list-dependencies`
- `debug-bar-remote-requests`
- `query-monitor`

To install these in any install, use the included command `install-debug-plugins`.

## Username/Password for Login

- Username: `admin`
- Password: `password`

## Usage

```bash
newvwp sitename --spatie/ray --mailhog --debug-bar
```

Here `sitename` will create `sitename.test`.

### Flags

```
--spatie/ray Installs https://spatie.be/products/ray support using Composer.
--mailhog    Installs wp-mailhog-smtp plugin for Mailhog support 
             (if you don't use this wp_mail() will be disabled by default).
--debug-bar  Installs all debug-bar-* plugins and activates them.
```

### Floating Commands

You can use these floating commands (functions) from the root of your WordPress install:

```
set-debug-constats      (Will just set the constants)
install-mailhog-plugin  (Will just install the plugin for Mailhog)
install-spatie-ray-wp   (Will just require spatie/ray and load it in wp-config.php)
disable-wp-mail         (Will disable wp_mail() in wp-config.php)
```

### Mailhog

Use `brew install mailhog && brew services start mailhog && valet proxy mailhog.test http://127.0.0.1:8025` to setup Mailhog on your local, then any emails send from the new site will re-direct email to Mailhog.

_If you don't use Mailhog we will automatically disable `wp_mail()` for you._

## MySQL

This assumes you have `mysql` installed and uses `127.0.0.1` as `dbhost`, and `root` as `dbuser` w/out a password. It will attempt to create a database with the name you choose using:

```bash
newvwp example [flags]
```

So here it will create `example`.

## TLD

This also assumes you are using the `.test` TLD in it's messaging, but you can just ignore the messaging and use your TLD.

## Required Commands

- `valet`
- `composer`
- `wp`

## Install

Using [antigen](https://github.com/zsh-users/antigen):

```bash
antigen bundle aubreypwd/zsh-plugin-newvwp
```

## Development

Install the package on `master`:

```bash
antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-newvwp
```

...and contribute upstream by working in `$HOME/.antigen/bundles/aubreypwd/zsh-plugin-newvwp`.