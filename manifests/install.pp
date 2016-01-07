class s3fs::install {

  Exec {
    path => '/usr/bin/:/bin:/usr/sbin:/sbin',
  }

  $s3fs_tarball = "v${s3fs::s3fs_version}.tar.gz"

  #Install S3FS
  wget::fetch { 's3fs':
    source      => "${s3fs::tarball_url}/${s3fs_tarball}",
    destination => "${s3fs::tarball_dir}/${s3fs_tarball}",
  }
  exec {'extract-s3fs':
    cwd     => $s3fs::tarball_dir,
    command => "tar zxf ${s3fs_tarball}",
    creates => "${s3fs::tarball_dir}/s3fs-fuse-${s3fs::s3fs_version}",
    require => Wget::Fetch['s3fs'],
  }
  exec {'autogen-configure-s3fs':
    cwd      => "${s3fs::tarball_dir}/s3fs-fuse-${s3fs::s3fs_version}/",
    provider => 'shell',
    command  => './autogen.sh',
    creates  => "${s3fs::tarball_dir}/s3fs-fuse-${s3fs::s3fs_version}/configure",
    require  => [ Exec['extract-s3fs'], Exec['compile-fuse'], ],
  }
  exec {'configure-s3fs':
    cwd         => "${s3fs::tarball_dir}/s3fs-fuse-${s3fs::s3fs_version}/",
    provider    => 'shell',
    environment => 'PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/lib64/pkgconfig/',
    command     => './configure --prefix=/usr',
    creates     => "${s3fs::tarball_dir}/s3fs-fuse-${s3fs::s3fs_version}/Makefile",
    require     => [ Exec['extract-s3fs'], Exec['compile-fuse'], Exec['autogen-configure-s3fs'], ],
  }
  exec {'compile-s3fs':
    cwd      => "${s3fs::tarball_dir}/s3fs-fuse-${s3fs::s3fs_version}/",
    provider => 'shell',
    command  => 'make && make install',
    unless   => "/usr/bin/s3fs --version | grep ${s3fs::s3fs_version}",
    require  => Exec['configure-s3fs'],
  }

}
