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

def main():
    arguments = docopt(__doc__)
    comp, action = get_args()

    if comp == 'hs':
        if action == 'list':
            return hs_list()
        if action=='add':
            

def hs_list():
    with open("hs_list.json") as json_file:
        hs_list = json.load(json_file)
        print(hs_list)

def hs_add(name, path, enabled, port_maps, auth_type, auth_info):
    hs = {}
    hs['name'] = name
    hs['path'] = path
    hs['enabled'] = enabled
    hs['port_maps'] = 
    with open("hs_list.json") as json_file:
        hs_list = json.load(json_file)
        

main()
