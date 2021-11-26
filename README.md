# `newvwp`

Spins up a new WordPress site using Valet. 

If you run this in an un-parked directory, it will prompt you to park the directory. It will then create the directory, install WordPress, setup constants for you, and optionally install `spatie/ray` and `debug-bar-*` plugins for you.

## Constants

These constants are set during setup, and are not customizable at the moment.

```
DISABLE_WP_CRON true 
EMPTY_TRASH_DAYS 0 
WP_MAX_MEMORY_LIMIT 4096 
WP_MEMORY_LIMIT 4096 
COMPRESS_CSS false 
COMPRESS_SCRIPTS false 
CONCATENATE_SCRIPTS false 
ENFORCE_GZIP false 
FS_METHOD direct
WP_DEBUG true 
SCRIPT_DEBUG true 
WP_DEBUG_DISPLAY false 
WP_DEBUG_LOG true 
FORCE_SSL_ADMIN true
FORCE_SSL_LOGIN true
SAVE_QUERIES true 
```

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

## Username/Password for Login

- Username: `admin`
- Password: `password`

## MySQL

This assumes you have `mysql` installed and uses `127.0.0.1` as `dbhost`, and `root` as `dbuser` w/out a password.

It will attempt to create the database for you, but if it exists the install steps will fail!

## TLD

This also assumes you are using the `.test` TLD in it's messaging, but you can just ignore the messaging and use your TLD.

## Usage

```bash
newvwp --spatie/ray --mailhog --debug-bar
```

### Flags

```
--spatie/ray Installs https://spatie.be/products/ray support using Composer.
--mailhog    Installs wp-mailhog-smtp plugin for Mailhog support.
--debug-bar  Installs all debug-bar-* plugins and activates them.
```

## Required Commands

- `valet`
- `composer`
- `wp`

## Install

Using [antigen](https://github.com/zsh-users/antigen):

```bash
antigen bundle aubreypwd/zsh-plugin-newvwp@1.0.0
```

## Development

Install the package on `master`:

```bash
antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-newvwp
```

...and contribute upstream by working in `$HOME/.antigen/bundles/aubreypwd/zsh-plugin-newvwp`.

---

## Changelog

### 1.0.0

- First version built for _Five for the Future_; thanks [@WebDevStudios](https://webdevstudios.com/)
