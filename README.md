# Systemd metered connection dependency
Execute systemd services if current connection is not metered.

## Installation

Install the systemd files in `/usr/local/lib/systemd/system`. Do not install `exemple.service`

Install `check-metered-connection.sh` in `/usr/local/bin`.

Execute `systemctl daemon-reload`

## Usage

Add the following to any unit you do not want to execute on a metered connection

```
[Unit]
Requires=check-metered-connection.service
After=check-metered-connection.service
```

## Things to improve

Support other connection managers

Display better logs

Package it
