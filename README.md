# yumupdate

#### Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Limitations - OS compatibility, etc.](#limitations)
4. [Development - Guide for contributing to the module](#development)

## Overview

Manage `yum.conf` and schedule automatic yum updates.

## Usage

Default behaviour is for the module to hash the node's IP address to generate an
hour and a minute for the update cron job to run, to stagger yum updates across your
esate between 02:00 and 07:59 on weekdays.

### `hour`
Cron hour that the update job should run, from 0-23. Default: `$::cron_hour` (a random value between 2-7)

### `minute`
Cron minute that the update job should run, from 0-59. Default: `$::cron_minute` (a random value between 0-59)

### `weekday`
Day(s) of the week that the update job should run, specified as an array. Default: `['1-5']` (weekdays only)

### `exclude`
Array of packages to exclude from the update job

```puppet
include ::yumupdate
```

If you want to force the same time on every node, set these parameters:

```puppet
class { 'yumupdate':
  hour   => 5,
  minute => 30,
}
```

Example where we don't upgrade the kernel:

```puppet
class { 'yumupdate':
  exclude => ['kernel'],
}
```

## Limitations

Only works on systems that use Yum for package management. Designed with CentOS
but should work on any RHEL-compatible Linux distribution.

## Development

Pull requests welcome.
