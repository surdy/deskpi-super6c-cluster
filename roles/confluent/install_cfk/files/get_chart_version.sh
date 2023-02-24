#!/usr/bin/env bash

if [ -z "$1" ]; then
    helm search repo confluentinc/confluent-for-kubernetes -l | head -n 2 | tail -n 1 | awk '{print $2}'
else
    helm search repo confluentinc/confluent-for-kubernetes -l | grep "$1" | awk '{print $2}'
fi
