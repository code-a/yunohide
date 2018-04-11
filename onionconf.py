import argparse
import json

def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '-c', '--component', type=str, help='Component', required=True
    )
    parser.add_argument(
        '-a', '--action', type=str, help='Action', required=True
    )

    args = parser.parse_args()

    return args.action, args.email, args.user, args.pw, args.cert_path
    
    def main():
    comp, action = get_args()

    if comp == 'hs':
        if action == 'list':
            return hs_list()

def hs_list():
    with open("hs_list.json") as json_file:
        hs_list = json.load(json_file)
        print(hs_list)

def hs_add(name, path, enabled, port_maps, auth_type, auth_info):
    hs = {}
    hs['name'] = name
    hs['path'] = path
    hs['enabled'] = enabled
    hs['port_maps'] = port_maps
    with open("hs_list.json") as json_file:
        hs_list = json.load(json_file)
        

main()
