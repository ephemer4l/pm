# pm
Minimal password manager

## Motivation
 
I don't like the dependencies `pass` pulls on my system and I don't need many of its features.

## Setup

Just make it executable with `chmod +x pm` and put it in your path. (preferably `~/.local/bin/`).
### Optional
- To generate passwords, do the same for my `pwgen` script.
- To generate passphrases, copy the file `eff_large_wordlist.txt` (or any other wordlist you want) into `~/.local/share/`.
## Usage

### Insert a new password
```sh
pm i name
```
### Remove a password
```sh
pm r name
```
### Show a new password
```sh
pm s name
```
### Generate and add new password with length k
```sh
pm g name k
```
### Generate and add passphrase with k words
```sh
pm gw name k
```

## Non-features
- No automatic copy option. It is easy to pipe things to `xclip` or `wl-copy`.
- No otp support.
- No QR codes.
