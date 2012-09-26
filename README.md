# DESCRIPTION:

Installs and runs unattended_upgrades.

# REQUIREMENTS:

apt

Currently tested on Ubuntu 12.04 ONLY.

# ATTRIBUTES:

Do `apt-get update` automatically every n-days (0=disable):

    node[:unattended_upgrades][:update_package_list_interval] = 1

Do `apt-get upgrade --download-only` every n-days (0=disable):

    node[:unattended_upgrades][:download_upgradeable_package_interval] = 1

Run the `unattended-upgrade` security upgrade script every n-days (0=disabled):

    node[:unattended_upgrades][:unattended_upgrade_interval] = 1

Do `apt-get autoclean` every n-days (0=disable):

    node[:unattended_upgrades][:autoclean_interval] = 7

Automatically upgrade packages from these (origin:archive) pairs:

    node[:unattended_upgrades][:allowed_origins] = [ '${distro_id}:${distro_codename}-security' ]

**Be sure to use single quotes so you don't expand `${distro_id}` and `${distro_codename}` with Ruby!**

Possible values for `:allowed_origins` include:

      [ '${distro_id}:${distro_codename}-security',
        '${distro_id}:${distro_codename}-updates',
        '${distro_id}:${distro_codename}-proposed',
        '${distro_id}:${distro_codename}-backports' ]

List of packages to not update:

    node[:unattended_upgrades][:package_blacklist] = []

This option allows you to control if on a unclean `dpkg` exit, `unattended-upgrades`
will automatically run `dpkg --force-confold --configure -a`. The default is
`true`, to ensure updates keep getting installed.

    node[:unattended_upgrades][:auto_fix_interrupted_dpkg] = true

Split the upgrade into the smallest possible chunks so that
they can be interrupted with `SIGUSR1`. This makes the upgrade
a bit slower but it has the benefit that shutdown while a upgrade
is running is possible (with a small delay).

    node[:unattended_upgrades][:minimal_steps] = false

Install all `unattended-upgrades` when the machine is shutting down
instead of doing it in the background while the machine is running.
This will (obviously) make shutdown slower.

    node[:unattended_upgrades][:install_on_shutdown] = false

Send email to this address for problems or packages upgrades.
If empty or unset then no email is sent, make sure that you
have a working mail setup on your system. A package that provides
`mailx` must be installed.

    node[:unattended_upgrades][:mail] = nil

Set this value to `true` to get emails only on errors. Default
is to always send a mail if `:mail` is set.

    node[:unattended_upgrades][:mail_only_on_error] = false

Do automatic removal of new unused dependencies after the upgrade
(equivalent to `apt-get autoremove`).

    node[:unattended_upgrades][:remove_unused_dependencies] = true

Automatically reboot **WITHOUT CONFIRMATION** if a
the file /var/run/reboot-required is found after the upgrade.

    node[:unattended_upgrades][:automatic_reboot] = false

Use apt bandwidth limit feature (in kb/sec).

    node[:unattended_upgrades][:download_limit] = nil

_Documentation from `/etc/cron.daily/apt` and `/etc/apt/apt.conf.d/50unattended-upgrades`._

# USAGE:

* Add cookbook ``unattended_upgrades`` to your runlist. This will install and run unattended_upgrades on your machine.
