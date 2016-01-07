# puppet-s3fs

## Overview

This module installs S3FS and FUSE from source tarballs. Note this is only tested on CentOS 6.x.

## Usage

```
  class { 'wget': } ->
  class { 's3fs': } ->
  class { 's3fs::credentials':
    accesskey       => 'ABCDEFG',
    secretaccesskey => 'HIJKLMNOPQRS',
  }
  ->
  s3fs::config { 'mybucket':
    bucket     => 'com.myorg.mybucket',
    mountpoint => '/mnt/mybucket',
    options    => 'passwd_file=/root/.passwd-s3fs,allow_other',
  }
```
