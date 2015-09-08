hiera_include('classes')

node 'ip-10-0-0-185.us-west-2.compute.internal' {
  class { 'apache': }
}
