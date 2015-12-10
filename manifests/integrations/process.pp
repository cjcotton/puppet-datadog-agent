# Class: datadog_agent::integrations::process
#
# This class will install the necessary configuration for the process integration
#
#
# Sample Usage:
# {
#   "dd::process": {
#     "dd::process::name": "apache2",
#     "dd::process::search_strings": "apache2",
#     "dd::process::exact_match": "false"
#   }
# }
#
class datadog_agent::integrations::process(
) inherits datadog_agent::params {

  $dd_process     = hiera('dd::process')
  $process_name   = $dd_process['dd::process::name']
  $search_strings = $dd_process['dd::process::search_strings']
  $exact_match    = $dd_process['dd::process::exact_match']

  file { "${datadog_agent::params::conf_dir}/process.yaml":
    ensure  => file,
    owner   => $datadog_agent::params::dd_user,
    group   => $datadog_agent::params::dd_group,
    mode    => '0600',
    content => template('datadog_agent/agent-conf.d/process.yaml.erb'),
    require => Package[$datadog_agent::params::package_name],
    notify  => Service[$datadog_agent::params::service_name]
  }
}
