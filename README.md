# Newcore Kafka Ansible

Configure a three-node Apache Kafka KRaft cluster on prepared Debian hosts.
Broker, controller, and client traffic use mutual TLS. The role never creates,
formats, partitions, or resizes a filesystem.

## Prerequisites

- Three hosts with stable DNS names and synchronized clocks.
- A dedicated filesystem already mounted at `kafka_data_dir` on every host.
- A unique certificate and key per host plus a shared CA under ignored
  `private/<inventory_hostname>/` directories.
- Network policy allowing only approved clients to `9093` and cluster members
  to `9094`.

## Deploy

```bash
cp -R inventories/example inventories/local
./scripts/fetch-kafka.sh
export KAFKA_CLUSTER_ID="$(openssl rand -base64 16 | tr -d '=+/')"
ansible-playbook -i inventories/local/hosts.yml playbooks/site.yml --check
ansible-playbook -i inventories/local/hosts.yml playbooks/site.yml
```

The cluster ID must remain stable for the life of the cluster. Store it in a
secret manager for real environments. Before an upgrade, verify replication,
back up configuration, and test broker removal. Use
`playbooks/rolling-update.yml` for later package or configuration changes. Run
`make check` in pull requests.
