# Contributing

Describe topology, compatibility, durability, and rolling-upgrade impact in each
pull request. Include `make check` output and a rollback plan. Changes to quorum,
replication, listeners, authorization, or storage require focused review.

Never commit certificates, private keys, real inventory, cluster IDs, or data.
Filesystem creation and destructive storage operations are prohibited.
