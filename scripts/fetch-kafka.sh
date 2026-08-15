#!/usr/bin/env bash
set -euo pipefail

version="${KAFKA_VERSION:-4.3.1}"
scala_version="${KAFKA_SCALA_VERSION:-2.13}"
name="kafka_${scala_version}-${version}.tgz"
destination="artifacts/${version}"
base_url="${KAFKA_DOWNLOAD_BASE_URL:-https://dlcdn.apache.org/kafka/${version}}"

mkdir -p "${destination}"
curl --fail --location --proto '=https' --tlsv1.2 --retry 5 --retry-all-errors \
  --output "${destination}/${name}" "${base_url}/${name}"
curl --fail --location --proto '=https' --tlsv1.2 --retry 5 --retry-all-errors \
  --output "${destination}/${name}.publisher.sha512" "${base_url}/${name}.sha512"
(
  cd "${destination}"
  expected="$(sed '1s/^[^:]*://' "${name}.publisher.sha512" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')"
  printf '%s  %s\n' "${expected}" "${name}" >"${name}.sha512"
  sha512sum --check --strict "${name}.sha512"
)
