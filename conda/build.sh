#!/bin/sh

set -eu

case "$(uname -s)" in
Linux)	OS=l;;
Darwin)	OS=m;;
*)	echo unknown OS >&2
	exit 1
	;;
esac

mkdir -p "${PREFIX}/${PKG_NAME}"
cp -r "${SRC_DIR}/${OS}${ARCH}" "${SRC_DIR}/q.k" "${PREFIX}/${PKG_NAME}"
chmod +x "${PREFIX}/${PKG_NAME}/${OS}${ARCH}/q"
ln -s -t "${PREFIX}/bin" "../${PKG_NAME}/${OS}${ARCH}/q"

cp "${RECIPE_DIR}/../kc.lic.py" "${PREFIX}/${PKG_NAME}"

for CHANGE in activate deactivate; do
	mkdir -p "${PREFIX}/etc/conda/${CHANGE}.d"
	cp "${RECIPE_DIR}/${CHANGE}.sh" "${PREFIX}/etc/conda/${CHANGE}.d/${PKG_NAME}-${CHANGE}.sh"
done

exit 0
