# Apache BuildPack
This BuildPack will install the Apache2 web server using the apt-buildpack.

## Configuration

If an `apache.conf.erb` is present at the root of your project, it will be
rendered (useing ERB template system) and included in the default
configuration.

## Environment tweaks

* `APACHE_LOG_LEVEL`: (default: `info`) Define the apache log level among the following:
  * `emerg`	System is unusable
  * `alert`	Action must be taken immediately
  * `crit`	Critical conditions
  * `error`	Error conditions
  * `warn`	Warning conditions
  * `notice`	Normal, but significant conditions
  * `info`	Informational messages
  * `debug`	Debugging messages
  * `trace1` – `trace8` Trace messages with gradually increasing levels of detail
