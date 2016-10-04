class s3fs (
  $s3fs_version    = $::s3fs::params::s3fs_version,
  $fuse_version    = $::s3fs::params::fuse_version,
  $tarball_url     = $::s3fs::params::tarball_url,
  $fuse_url        = $::s3fs::params::fuse_url,
  $tarball_dir     = $::s3fs::params::tarball_dir,
  $fuse_pkg        = $::s3fs::params::fuse_pkg,
  $s3fs_pkg        = $::s3fs::params::s3_pkg,
  $dependency_pkgs = $::s3fs::params::dependency_pkgs,
  $conflict_pkgs   = $::s3fs::params::conflict_pkgs,
) inherits s3fs::params {

  anchor { '::s3fs::begin': } ->
  class { '::s3fs::dependencies': } ->
  class { '::s3fs::fuse': } ->
  class { '::s3fs::install': } ->
  anchor { '::s3fs::end': }

}
