#!/usr/bin/env bash
#
# We don't want to run drush commands if drupal isn't installed.
# Similarly, we don't want to attempt to run config-import if there aren't any config files to import
# @todo expand further to pass --uri for all sites, with an eye towards multisite
#


if [ -n "$(drush status --field=bootstrap)" ]; then
  drush -y cache-rebuild
  drush -y updatedb

  should_import_config=true

  if [ "$SKIP_CONFIG_IMPORT" = "1" ]; then
    should_import_config=false
  fi

  if [[ "$PLATFORM_BRANCH" == no-cim--* ]]; then
    should_import_config=false
  fi

  if [ "$should_import_config" = "true" ] && [ -n "$(ls $(drush php:eval "echo realpath(Drupal\Core\Site\Settings::get('config_sync_directory'));")/*.yml 2>/dev/null)" ]; then
    drush -y config-import
  else
    echo "Skipping config import."
  fi
else
  echo "Drupal not installed. Skipping standard Drupal deploy steps"
fi
