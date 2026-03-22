#!/usr/bin/env bash
set -euo pipefail

remote_name="${FLATPAK_REMOTE_NAME:-flathub}"
remote_title="${FLATPAK_REMOTE_TITLE:-mgl-xyz Flathub Remote}"
base_url="${FLATPAK_REMOTE_BASE_URL:?FLATPAK_REMOTE_BASE_URL must be set}"
output_dir="${OUTPUT_DIR:-public}"

mkdir -p "${output_dir}"

cat > "${output_dir}/${remote_name}.flatpakrepo" <<EOT
[Flatpak Repo]
Title=${remote_title}
Url=${base_url}/repo/
Homepage=${base_url}
Comment=Shared Flatpak remote for mgl-xyz applications
Description=Hosted Flatpak remote for Cursor and Trae packages maintained in mgl-xyz.
GPGVerify=false
EOT

if [[ "${remote_name}" != "flathub" ]]; then
  cp "${output_dir}/${remote_name}.flatpakrepo" "${output_dir}/flathub.flatpakrepo"
fi
