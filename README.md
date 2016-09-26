# yumupdate

#### Table of Contents

1. [Overview](#overview)
2. [Usage - Configuration options and additional functionality](#usage)
3. [Limitations - OS compatibility, etc.](#limitations)
4. [Development - Guide for contributing to the module](#development)

## Overview

Manage `yum.conf` and schedule automatic yum updates.

## Usage

The first version of this module takes no parameters, although more granular
control is on the roadmap.

```puppet
include ::yumupdate
```

## Limitations

Only works on systems that use Yum for package management. Designed with CentOS
but should work on any RHEL-compatible Linux distribution.

## Development

Pull requests welcome.
