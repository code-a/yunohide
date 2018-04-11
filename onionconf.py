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

def hs_list():
    try:
        with open("hs_list.json") as json_file:
            hs_list = json.load(json_file)
            print(hs_list)
    except Exception as e:
        print(e.message)

def dispatch_command(arguments, command='fail'):
    if command=='hs_list':
        print(hs_list())

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




"""
def hs_add(name, path, enabled, port_maps, auth_type, auth_info):
    hs = {}
    hs['name'] = name
    hs['path'] = path
    hs['enabled'] = enabled
    hs['port_maps'] =
    with open("hs_list.json") as json_file:
        hs_list = json.load(json_file)
"""

main()
