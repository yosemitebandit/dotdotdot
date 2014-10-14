"""Generates a _gitconfig file based on the $MACHINE env var
"""
import os
import sys

TEMPLATE_PATH = 'gitconfig.template'
OUTPUT_PATH = 'gitconfig'
EMAIL_TARGET = '{{EMAIL}}'

machine_env_var = os.environ['MACHINE']
if not machine_env_var:
  print 'please set $MACHINE in .zshenv'
  sys.exit(1)
email_address = os.environ['GITCONFIG_EMAIL_ADDRESS']

print 'injecting "%s" into _gitconfig template' % email_address
with open(TEMPLATE_PATH, 'r') as template, open(OUTPUT_PATH, 'w') as output:
  for line in template.readlines():
    output.write(line.replace(EMAIL_TARGET, email_address))
