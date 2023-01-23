#!/bin/bash

goaccess ../04/*.log
goaccess ../04/*.log -p goaccess.conf -o report.html
