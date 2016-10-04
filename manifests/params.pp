class s3fs::params {

  case $::operatingsystem {
    'CentOS', 'Fedora', 'Scientific', 'RedHat', 'Amazon': {
      $dependency_pkgs = [
            'gcc',
            'libstdc++-devel',
            'gcc-c++',
            'libcurl-devel',
            'libxml2-devel',
            'openssl-devel',
            'mailcap',
      ]
      $conflict_pkgs = [
        'fuse',
        'fuse-devel',
        'fuse-s3fs',
      ]
    }
    'Debian', 'Ubuntu': {
      fail("\"${module_name}\" provides no support yet
            for \"${::operatingsystem}\"")
    }
    default: {
      fail("\"${module_name}\" provides no support
            for \"${::operatingsystem}\"")
    }
  }

  $s3fs_version = '1.79'
  $tarball_url = 'https://github.com/s3fs-fuse/s3fs-fuse/archive'
  $fuse_url = 'https://github.com/libfuse/libfuse/releases/download/fuse_2_9_4'
  $fuse_version = '2.9.4'
  $tarball_dir = '/usr/local/src'

}
