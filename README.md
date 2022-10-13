# Apache BuildPack
This BuildPack will install the Apache2 web server using the apt-buildpack.

## Configuration

If an `apache.conf.erb` is present at the root of your project, it will be
rendered (useing ERB template system) and included in the default
configuration.

## Apache modules

You can install custom apache modules by adding a `.apache-mods` file at the root
of your project. It must include one module per line.

Example:

```
auth-openidc
auth-mellon
```

## SSL Certificate and keys

If a `ssl` directory is present at the root of the project, il will be copied over with 
its content and made available in `${HOME}/vendor/apache2/`.

For example, you may use it as such in you `apache.conf.erb` file:

```
MellonSPPrivateKeyFile ${HOME}/vendor/apache2/ssl/sp-private-key.pem
```

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
