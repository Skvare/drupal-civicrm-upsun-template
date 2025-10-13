<?php

use Symfony\Component\Dotenv\Dotenv;

if (file_exists(__DIR__.'/.env')) {
  // @TODO https://github.com/symfony/symfony/issues/35388
  (new Dotenv())->usePutenv(true)->bootEnv(__DIR__.'/.env');
}
