/**
 * Only build libkraken.dylib for macOS
 */
require('./tasks');
const { series } = require('gulp');
const chalk = require('chalk');

const SUPPORTED_JS_ENGINES = ['jsc', 'v8'];
const libKrakenSeries = SUPPORTED_JS_ENGINES.map(jsEngine => [
  'generate-cmake-files-' + jsEngine,
  'build-kraken-lib-' + jsEngine
]);

// Run tasks
series(
  'compile-polyfill',
  libKrakenSeries,
  'copy-build-libs',
  'install-v8-name-prefix'
)((err) => {
  if (err) {
    console.log(err);
  } else {
    console.log(chalk.green('Success.'));
  }
});
