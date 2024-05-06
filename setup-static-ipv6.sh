#! /bin/bash

sudo ifconfig en1 inet6 2001:569:bfc6:c300::1000
sudo ifconfig en1 inet6 2001:569:bfc6:c300::1001
sudo ifconfig en1 inet6 2001:569:bfc6:c300::1002
ifconfig en1 | grep 2001

