#!/bin/sh

umask 077

entry_name="${2}"
entry_path="${PASSWORD_STORE_DIR:-$HOME/.password-store}/${entry_name}.gpg"

if [ -z "${entry_name}" ]; then
  echo "No entry name" && exit 1
fi

add() {
  if [ -z "${1}" ]; then
    echo "No password given." && exit 1
  fi
  mkdir -p "${entry_path%/*}"
  printf '%s\n' "${1}" | gpg --default-recipient-self --encrypt --output "${entry_path}"
}

case "${1}" in
  "s") gpg --decrypt --quiet "${entry_path}" ;;
  "i") 
    IFS= read -r -s -p "Password for '${entry_name}': " password && echo
    add "${password}" ;;
  "g") add "$(gp ${3})"  ;;
  "gw") add "$(gp word ${3})" ;;
  "r") rm "${entry_path}" ;;
esac

# vim: et:sw=2:sts=2
