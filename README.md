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

## The `apache.conf.erb` file

The `apache.conf.erb` file can be used to include specific configuration for your
environment. You may want to include variables as Ruby code in this file, which will
match environment variables from your container.
For example, you can create a variable `MY_VAR` in your container and use it in the
`apache.conf.erb` file with `<%= ENV["MY_VAR"] %>`. It will be matched to the corresponding 
environment variable and replaced with its value before starting Apache.

If you need to load modules in the Apache configuration, and these modules were included
in the `.apache-mods` file, they will autmatically be loaded in the Apache configuration.
You don't need to add the corresponding `LoadModule` directive to your `apache.conf.erb` 
file.

If no `apache.conf.erb` file is found, Apache will work as a simple HTTP server and will
serve the content of the `www` directory present on your application repository.

## Example setting up a basic OpenID-Connect Relying Party

To configure Apache as an OpenID-Connect Relying Party (RP), you can create an 
`apache.conf.erb` with the following code:

```
OIDCProviderMetadataURL <issuer>/.well-known/openid-configuration
OIDCClientID <%= ENV["OIDC_CLIENT_ID"] %>
OIDCClientSecret <%= ENV["OIDC_CLIENT_SECRET"] %>

OIDCRedirectURI https://<hostname>/secure/redirect_uri
OIDCCryptoPassphrase <%= ENV["OIDC_CRYPTO_PASSPHRASE"] %>

<Location /secure>
   AuthType openid-connect
   Require valid-user
</Location>
```
And create the following environment variables in your container:
* `OIDC_CLIENT_ID=<client_id_value>`
* `OIDC_CLIENT_SECRET=<client_secret_value>`
* `OIDC_CRYPTO_PASSPHRASE=<crypto_passphrase_value>`
