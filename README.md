# Systemd metered connection dependency
Execute systemd services if current connection is not metered.

## Installation
```
Install `unmetered-connection.service` in `/usr/local/lib/systemd/system`.
Install `check-metered-connection.sh` in `/usr/local/bin`.
Execute `systemctl daemon-reload`
```

/!\ If you want it to be available to your users:
```
Install `unmetered-connection.service` in `/usr/local/lib/systemd/user`.
Execute `systemctl --user daemon-reload`
```

## Usage

### Systemd

Add the following to any unit you do not want to execute on a metered connection

```
[Unit]
Requires=unmetered-connection.service
After=unmetered-connection.service
```

See `exemple.service` for an exemple usage.

### Network Manager

Network Manager might not guess the metered connection status. If so, use the following to mark a connection as metered:

```
$ nmcli con modify <connection-name> connection.metered yes
```

## How does it work ?

  1. When you add the `unmetered-connection.service` dependency to your service with `Requires` and `After`, on activation, your service will start `unmetered-connection.service`.
  2. `unmetered-connection.service` will execute the `check-metered-connection.sh` bash script.
  3. `check-metered-connection.sh` then uses DBUS and NetworkManager to check on the current connection status. It returns 0 for an unmetered connection and 1 for a metered connection.
  4. If the script returns zero, `unmetered-connection.service` will fail, preventing execution of your service.

## Things to improve

Support other connection managers

Display better logs

Package it (AUR)

Manage multiple connections

Disable metered verification through a service

Directly hook DBUS to systemd service

Use systemd target to start/stop services ?
