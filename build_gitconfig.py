"""Generates a _gitconfig file based on the $MACHINE env var

todo:
  this should build several dotfiles: zshrc, gitconfig, vimrc
  it should just take an argument and not require a var to be set
  it should just echo the relevant data into the dotfiles
  so you can remove the big switch statement in zshrc
  and, for instance, you can inject custom vimrc plugins
  machine types: ubuntu64, ubuntu32, mac, work laptop, work desktop
"""
import os
import sys

TEMPLATE_PATH = 'gitconfig.template'
OUTPUT_PATH = 'gitconfig'
EMAIL_TARGET = '{{ EMAIL }}'

machine_env_var = os.environ['MACHINE']
if not machine_env_var:
  print 'please set $MACHINE in .zshenv'
  sys.exit(1)
email_address = os.environ['GITCONFIG_EMAIL_ADDRESS']

print 'injecting "%s" into _gitconfig template' % email_address
with open(TEMPLATE_PATH, 'r') as template, open(OUTPUT_PATH, 'w') as output:
  for line in template.readlines():
    output.write(line.replace(EMAIL_TARGET, email_address))
