#!/bin/bash
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook ./playbooks/wireguard_sever_config.yml -i ./inventory/inventory.yaml --ask-pass --ask-become