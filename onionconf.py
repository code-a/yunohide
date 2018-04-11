"""
A command-line interface for managing tor & hidden services.

usage:
    onionconf (-h | --help)
    onionconf hs_list
    onionconf hs_add [--name=<name>] [--path=<path>] [--enabled=<enabled>] [--portmap=<portmap>]
    onionconf hs_add_auth

    onionconf --version
"""


from docopt import docopt
import json

def is_command(s):
    if s.startswith('-'):
        return False
    if s.startswith('<'):
        return False
    return True

def parse_portmap(portmap_string):
    # //TODO: implement


def hs_list():
    try:
        with open("hs_list.json") as json_file:
            hs_list = json.load(json_file)
            print(hs_list)
    except Exception as e:
        print(e.message)

def hs_add(arguments):
    hs = {}
    hs['name'] = arguments['--name']
    hs['path'] = arguments['--path']
    hs['enabled'] = arguments['--enabled']
    hs['port_maps'] = arguments['--portmap']

    # //TODO: load json and merge new object
    # //TODO: check if service name already exists
    with open("hs_list.json", "w") as json_file:
        #hs_list = json.load(json_file)
        json.dump(hs, json_file)

def update_torrc():
    # //TODO: implement

def dispatch_command(arguments, command='fail'):
    if command=='hs_list':
        print(hs_list())
    elif command=='hs_add':
        print(hs_add(arguments))

def main():
    arguments = docopt(__doc__)
    version_string = 'alpha'
    arguments = docopt(__doc__, version=version_string)
    command = list([
        k for (k, v) in arguments.iteritems()
        if (v and is_command(k))])[0]
    try:
        dispatch_command(arguments, command)
    except Exception as e:
        print(e)








main()
