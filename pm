#!/bin/sh

umask 077

entry_name="${2}"
entry_path="${PASSWORD_STORE_DIR:-$HOME/.password-store}/${entry_name}.gpg"

if [ -z "${entry_name}" ]; then
  echo "No entry name" && exit 1
fi

alias gpg="gpg --quiet --yes --batch --default-recipient-self"

add() {
  if [ -e "${entry_path}" ]; then
    read -p "Entry exists. Override? [y/n] " -n 1 -r; echo
    [[ $REPLY =~ ^[Yy]$ ]] || exit 1
  fi
  if [ -z "${1}" ]; then
    echo "No password given." && exit 1
  fi
  mkdir -p "${entry_path%/*}"
  printf '%s\n' "${1}" | gpg --encrypt --output "${entry_path}"
}

case "${1}" in
  "s") gpg --decrypt "${entry_path}" ;;
  "i") 
    IFS= read -r -s -p "Password for '${entry_name}': " password && echo
    add "${password}" ;;
  "g") add "$(gp ${3})"  ;;
  "gw") add "$(gp word ${3})" ;;
  "r") rm "${entry_path}" ;;
esac

# vim: et:sw=2:sts=2
