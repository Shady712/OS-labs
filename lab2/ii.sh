#!/bin/bash

ps -axo pid,command | grep "/sbin/" | awk '{printf $1"\n"}'