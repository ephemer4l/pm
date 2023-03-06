#!/bin/sh

umask 077

entry_name="${2}"
entry_path="${PASSWORD_STORE_DIR:-$HOME/.password-store}/${entry_name}.gpg"

enc="gpg --default-recipient-self --encrypt --output ${entry_path}"
mk="mkdir -p ${entry_path%/*}"

case "${1}" in
  "s") gpg --decrypt --quiet "${entry_path}" ;;
  "i") 
    IFS= read -r -s -p "Password for ${entry_name}: " password && echo
    $mk && printf '%s\n' "${password}" | $enc ;;
  "g") $mk && gp ${3} | $enc  ;;
  "gw") $mk && gp word ${3} | $enc ;;
  "r") rm "${entry_path}" ;;
esac

# vim: et:sw=2:sts=2
