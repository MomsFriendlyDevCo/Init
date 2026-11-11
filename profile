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

# SMTP relay for the system outgoing emailer (030-mta-smtp)
# Leave PROFILE_MTA_SMTP_SERVER blank to skip SMTP relay setup entirely
# Leave PROFILE_MTA_SMTP_USER blank to skip authentication, PROFILE_MTA_SMTP_FROM blank to skip sender rewriting
# PROFILE_MTA_SMTP_PORT defaults to 587 (STARTTLS), use 465 for implicit TLS
PROFILE_MTA_SMTP_SERVER=''
PROFILE_MTA_SMTP_PORT=''
PROFILE_MTA_SMTP_USER=''
PROFILE_MTA_SMTP_PASS=''
PROFILE_MTA_SMTP_FROM=''

# Test email defaults (999-mta-test)
# If PROFILE_MTA_TEST_TO is set, 030-mta-smtp will also send a test email when done
PROFILE_MTA_TEST_TO=''
PROFILE_MTA_TEST_FROM=''
PROFILE_MTA_TEST_SUBJECT=''

# Group allowed to connect via RDP (999-rdp)
PROFILE_RDP_GROUP=rdp-access

# Disable screen locking within RDP sessions (y|n) (999-rdp)
PROFILE_RDP_DISABLE_SCREENLOCK=y

# Try to use few system resources when using `INIT cargo-install`
# This will make the builds slower but consume fewer system resources
# ENUM: 0 (use regular install profile), 1 (optimize), 'auto' ('1' if CPU count >2)
PROFILE_CARGO_INSTALL_OPTIMIZE=0
