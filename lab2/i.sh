#!/bin/bash

ps -a -u root --format pid,command | awk '{printf $1":"$2"\n"}'