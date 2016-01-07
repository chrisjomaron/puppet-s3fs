class s3fs::fuse {

  Exec {
    path => '/usr/bin/:/bin:/usr/sbin:/sbin',
  }

  $fuse_tarball = "fuse-${s3fs::fuse_version}.tar.gz"

  #Install a new version of Fuse
  wget::fetch { 'fuse':
    source      => "${s3fs::fuse_url}/${fuse_tarball}",
    destination => "${s3fs::tarball_dir}/${fuse_tarball}",
    require     => Package[$::s3fs::fuse_pkg],
  }
  exec {'extract-fuse':
    cwd     => $s3fs::tarball_dir,
    command => "tar zxf ${fuse_tarball}",
    creates => "${s3fs::tarball_dir}/fuse-${s3fs::fuse_version}",
    require => Wget::Fetch['fuse'],
  }
  exec {'configure-fuse':
    cwd      => "${s3fs::tarball_dir}/fuse-${s3fs::fuse_version}/",
    provider => 'shell',
    command  => './configure --prefix=/usr',
    creates  => "${s3fs::tarball_dir}/fuse-${s3fs::fuse_version}/Makefile",
    require  => Exec['extract-fuse'],
  }
  exec {'compile-fuse':
    cwd      => "${s3fs::tarball_dir}/fuse-${s3fs::fuse_version}/",
    provider => 'shell',
    command  => 'make && make install && ldconfig',
    unless   => "/usr/bin/fusermount -V | grep ${s3fs::fuse_version}",
    require  => Exec['configure-fuse'],
  }

}
