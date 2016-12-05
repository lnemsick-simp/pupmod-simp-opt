#
# simp_options class.
#
# Sets up variables that enable core SIMP capabilities or provide site
# configuration larger than the scope of a single module.
#
# @param auditd Whether to include SIMP's ::auditd class and add audit
#          rules pertinent to each application
# @param clamav Whether SIMP should manage ClamAV
# @param fips Whether to enable FIPS mode for the system. This parameter
#          enforces strict compliance with FIPS-140-2.  All core SIMP modules
#          can support this configuration.  However, it is important that
#          you know the security tradeoffs of FIPS-140-2 compliance.
#          FIPS mode disables the use of MD5 and may require weaker ciphers
#          or key lengths than your security policies allow.
# @param firewall Whether to include SIMP's firewall class (simp::iptables)
#          and add rules pertinent to each application.
# @param haveged Whether to include the haveged class to ensure adequate
#          entropy for key generation
# @param ipsec Whether to include SIMP's ipsec class (simp::libreswan)
#          and add rules pertinent to each application.
# @param ipv6 - Whether to enable ipv6 functionality across the board.
# @param kerberos - Whether to include the SIMP's Kerberos class
#          (::krb5) and to use Kerberos in applicable modules
# @param ldap Whether modules should use LDAP.
# @param pam Whether to include SIMP’s ::pam class SIMP to manage the PAM stack
# @param pki Whether to include the simp::pki class and use pki::copy to
#           distribute PKI certificates to the correct locations
# @param selinux Whether to include the simp::selinux class (which effectively
#           manages the SELinux enforcement and mode) and manage SIMP-specific
#           SELinux configurations
# @param sssd Whether to use SSSD
# @param stunnel Whether to include SIMP’s ::stunnel class and use it to
#           secure server-to-server communications in applicable modules
# @param syslog Whether to include the  simp::rsyslog  class and configure
#           rsyslog application hooks
# @param tcpwrappers Whether to include the simp::tcpwrappers and use
#           tcpwrappers::allow to permit the application to the subnets in
#           $::simp_options::trusted_nets
# @param trusted_nets Subnets to permit, generally in CIDR notation. If you
#           need this to be more (or less) restrictive for a given class,
#           you can override it
# elsewhere in Hiera.
#
# @author SIMP Team
#
class simp_options (
  Boolean $auditd                           = false,
  Boolean $clamav                           = false,
  Boolean $fips                             = false,
  Boolean $firewall                         = false,
  Boolean $haveged                          = false,
  Boolean $ipsec                            = false,
  Boolean $ipv6                             = false,
  Boolean $kerberos                         = false,
  Boolean $ldap                             = false,
  Boolean $pam                              = false,
  Boolean $pki                              = false,
  Boolean $selinux                          = false,
  Boolean $sssd                             = false,
  Boolean $stunnel                          = false,
  Boolean $syslog                           = false,
  Boolean $tcpwrappers                      = false,
  Array[String] $trusted_nets               = ['127.0.0.1', '::1']
){
  validate_net_list($trusted_nets)

  include '::simp_options::dns'
  include '::simp_options::ntpd'
  include '::simp_options::openssl'
  include '::simp_options::puppet'
  include '::simp_options::rsync'

  if $ldap {
    include '::simp_options::ldap'
  }

  if $syslog {
    include '::simp_options::syslog'
  }
}
