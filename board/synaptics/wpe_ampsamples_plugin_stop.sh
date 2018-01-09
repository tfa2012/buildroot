#!/bin/sh

kill -SIGINT $(ps -A | grep -m1 ampclient_samples | awk '{print $1}')
