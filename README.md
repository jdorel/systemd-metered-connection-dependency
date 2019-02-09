# Systemd metered connection dependency
Execute systemd services if current connection is not metered.

## Installation

Install the `unmetered-connection.target` and `check-metered-connection.service` in `/usr/local/lib/systemd/system`.

Install `check-metered-connection.sh` in `/usr/local/bin`.

Execute `systemctl daemon-reload`

## Usage

### Systemd

Add the following to any unit you do not want to execute on a metered connection

```
[Unit]
Requires=check-metered-connection.service
After=check-metered-connection.service
```

See `exemple.service` for an exemple usage.

### Network Manager

Network Manager might not guess the metered connection status. If so, use the following to mark a connection as metered:

```
# shell> nmcli con edit <connection-name>
# nmcli> set connection.metered yes
# nmcli> save
# nmcli> quit
```

## How does it work ?

  1. When you add the `unmetered-connection.target` dependency to your service with `Requires` and `After`, if the target fails, the service won't start.
  2. `unmetered-connection.target` is dependent on `check-metered-connection.service`, if the service fails, the target will fail too.
  3. `check-metered-connection.service` calls the `check-metered-connection.sh` bash script.
  4. `check-metered-connection.sh` then uses DBUS and NetworkManager to check on the current connection status. It returns 0 for an unmetered connection and 1 for a metered connection.

## Things to improve

Support other connection managers

Display better logs

Package it

Manage multiple connections
