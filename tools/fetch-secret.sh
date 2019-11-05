#!/usr/bin/env sh
set -e

kubectl_args="${@}"

secret_dir="${SECRET_DIR}" 
if [ -z "${secret_dir}" ]; then
	secret_dir="./secrets"
	echo "[INFO] Using default SECRET_DIR \"${secret_dir}\"." 1>&2
fi
mkdir -p "${secret_dir}"

secret_keys="$(kubectl get secret ${kubectl_args} -o json|jq -r '.data|keys|.[]')"

for key in ${secret_keys}; do
	key_file="${secret_dir}/${key}" 
	if [ -e "${key_file}" ]; then
		echo "[INFO] File exists. Skipping \"${key_file}\"." 1>&2
		continue
	fi

	echo "${key_file}"
	val="$(kubectl get secret ${kubectl_args} -o json|jq -r ".data[\"${key}\"]"|base64 -D)"
	echo "${val}" > "${key_file}"
done
