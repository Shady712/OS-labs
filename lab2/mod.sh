#!/bin/bash

ps -ax -o user --sort=user | uniq -c
