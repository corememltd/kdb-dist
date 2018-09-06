[ "${QHOME}" ]	|| export QHOME="${CONDA_PREFIX}/kdb"
[ "${QLIC}" ]	|| export QLIC="${HOME}"

[ -f k4.lic ] || [ -f "${QLIC}/k4.lic" ] || [ -f "{QHOME}/k4.lic" ] \
	|| [ -f kc.lic ] || [ -f "${QLIC}/kc.lic" ] || [ -f "{QHOME}/kc.lic" ] \
	|| python "${CONDA_PREFIX}/kdb/kc.lic.py" \
	|| echo q non-functional, to re-run the license fetcher reactivate your env >&2
