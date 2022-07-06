#!/bin/zsh

###
	 # Create a new WordPress site using Valet.
	 #
	 # E.g: newvwp example
	 #
	 # @since Friday, November 26, 2021
	 #
	 # @TODO Move this to a ZSH plugin.
	 ##
	function newvwp {

		###
		 # Help for newvwp.
		 #
		 # E.g: Not for use.
		 #
		 # @since Friday, November 26, 2021
		 ##
		function newvwp_help {
			echo "Please specify a site name, e.g.:"
			echo
			echo "newvwp example [--flags]"
			echo
			echo " --spatie/ray Installs https://spatie.be/products/ray support using Composer."
			echo " --mailhog    Installs wp-mailhog-smtp plugin for Mailhog support."
			echo " --debug-bar  Installs all debug-bar-* plugins and activates them."

			return
		}

		if ! [[ -x $(command -v valet) ]]; then
			echo "Unable to find valet command, do you have it installed and in your PATH?"
			return;
		fi

		if ! [[ -x $(command -v wp) ]]; then
			echo "Please install wp-cli, as it is required to install plugins and setup WordPress."
			return;
		fi

		if [[ "$@" == *"spatie/ray"* ]]; then
			if ! [[ -x $(command -v composer) ]]; then
				echo "Please install composer, as it is required to require spatie/ray."
				return;
			fi
		fi

		if [[ -z "$1" ]]; then
			newvwp_help && return
		fi

		if [[ "$1" == *"--"* ]]; then
			newvwp_help && return
		fi

		if [[ "$1" == '--help' ]]; then
			newvwp_help && return
		fi

		local pwd=$(pwd)

		if read -q "choice?Are you sure you want to park '${pwd}' and create '$pwd/$1' and overwrite the database '$1' if there is any? [y/n]: "; then
			echo
			echo

			echo "You may be asked for your password to park ${pwd}..."
				echo

				# Park the current directory so that the folder we make inside can be served.
				valet park && \

					# Make the new site in this parked directory.
					mkdir -p "$1" && \
					cd "$1" && \

			echo "You may be asked for your password to secure '$1.test'..." && \
				valet secure && \

					echo && \
					echo "Installing WordPress in ${pwd}/$1..." && \
						wp core download && \
						wp config create --dbuser=root --dbhost="127.0.0.1" --dbname="$1" && \
						wp db create || true && \
						wp core install --url="https://$1.test" --title="$1" --admin_user="admin" --admin_email="noreply@example.com" && \

						echo && \
						echo "Changing admin user's password to 'password' instead..." && \
							wp user update admin --user_pass=password && \

								echo && \
								echo "Setting up constants..." && \
									wp config set BP_DEFAULT_COMPONENT 'staging-area' && \
									wp config set BP_XPROFILE_SLUG 'staging-area' && \
									wp config set COMPRESS_CSS false --raw && \
									wp config set COMPRESS_SCRIPTS false --raw && \
									wp config set CONCATENATE_SCRIPTS false --raw && \
									wp config set DISABLE_WP_CRON true --raw && \
									wp config set EMPTY_TRASH_DAYS 0 --raw && \
									wp config set ENFORCE_GZIP false --raw && \
									wp config set EP_DASHBOARD_SYNC false --raw && \
									wp config set EP_HOST 'http://failed.tld/' && \
									wp config set FORCE_SSL_ADMIN true --raw && \
									wp config set FORCE_SSL_LOGIN true --raw && \
									wp config set FS_CHMOD_DIR 0775 --raw && \
									wp config set FS_CHMOD_FILE 0664 --raw && \
									wp config set FS_METHOD 'direct' && \
									wp config set JETPACK_DEV_DEBUG true --raw && \
									wp config set SAVE_QUERIES true --raw && \
									wp config set SCRIPT_DEBUG true --raw && \
									wp config set WP_AUTO_UPDATE_CORE false --raw && \
									wp config set WP_CACHE false --raw && \
									wp config set WP_DEBUG true --raw && \
									wp config set WP_DEBUG_DISPLAY false --raw && \
									wp config set WP_DEBUG_LOG true --raw && \
									wp config set WP_ENVIRONMENT_TYPE 'local' && \
									wp config set WP_LOCAL_DEV true --raw && \
									wp config set WP_MAX_MEMORY_LIMIT 4096 --raw && \
									wp config set WP_MEMORY_LIMIT 4096 --raw

			if [[ "$@" == *"--spatie/ray"* ]]; then
				echo
				echo "Setting up spatie/ray..."
					composer init --name="no/installable" -q -n && \
						composer require spatie/ray && \
							wp config set '__SPATIE_RAY' "require __DIR__ . '/vendor/autoload.php'" --raw --type='variable'
			fi

			if [[ "$@" == *"--debug-bar"* ]]; then
				echo
				echo "Installing debug-bar-* plugins..."
					wp plugin install --activate debug-bar
					wp plugin install --activate debug-bar-console
					wp plugin install --activate debug-bar-shortcodes
					wp plugin install --activate debug-bar-constants
					wp plugin install --activate debug-bar-post-types
					wp plugin install --activate debug-bar-cron
					wp plugin install --activate debug-bar-actions-and-filters-addon
					wp plugin install --activate debug-bar-transients
					wp plugin install --activate debug-bar-list-dependencies
					wp plugin install --activate debug-bar-remote-requests
					wp plugin install --activate query-monitor
			fi

			if [[ "$@" == *"--mailhog"* ]]; then
				echo
				echo "Installing wp-mailhot-smtp..."
					wp plugin install --activate wp-mailhog-smtp
			fi

			echo
			echo "Done - https://$1.test/wp-login.php"
				echo "\tUsername: admin"
				echo "\tPassword: password"
		fi
	}
