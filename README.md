  class { 's3fs':
    tarball_url  => 'http://mydomain.com/s3fs/',
    s3fs_version => '1.78',
    fuse_version => '2.9.3',
  }
  ->
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
