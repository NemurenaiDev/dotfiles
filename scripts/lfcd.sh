#!/bin/bash

rm "/tmp/lf-shellcd-lastdir" "/tmp/lf-shellcd-changecwd" 2>/dev/null
lf -last-dir-path "/tmp/lf-shellcd-lastdir" -command "source '$HOME/.config/lf/lfrc'" "$@"
if [ -e "/tmp/lf-shellcd-changecwd" ] && \
	dir="$(cat "/tmp/lf-shellcd-lastdir")" 2>/dev/null; then
	echo "$dir"
fi