#!/bin/bash
source ~/ryu-env/bin/activate
MODE=dynamic ryu-manager controller.py
