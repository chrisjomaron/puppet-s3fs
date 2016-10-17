class s3fs::dependencies {

  # Making sure fuse and s3fs are not installed from package manager
  package { $::s3fs::conflict_pkgs : ensure => absent, }

  package { $::s3fs::dependency_pkgs : ensure => installed, }

}
