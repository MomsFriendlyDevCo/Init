# Leave as empty to use system setting
PROFILE_TIMEZONE=

# Preferred hostname, leave blank to always prompt
PROFILE_HOSTNAME=

# Swap file size (003-swap)
PROFILE_SWAP_SIZE=4G

# Swappiness (003-swappiness)
# Standard Default=60, lower numbers mean more RAM but less disk usage, higher means crash to disk more often
# For servers, lower is better
PROFILE_SWAPPINESS=30

# Default Zabbix server to use
PROFILE_ZABBIX_SERVER=calculon.mfdc.io

# Default Rsyslog upstream server
PROFILE_RSYSLOG_UPSTREAM=calculon.mfdc.io

# Group allowed to connect via RDP (999-rdp)
PROFILE_RDP_GROUP=rdp-access

# Disable screen locking within RDP sessions (y|n) (999-rdp)
PROFILE_RDP_DISABLE_SCREENLOCK=y
