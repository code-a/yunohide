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
    parser.add_argument(
        '-n', '--name', type=str, help='Name', required=False
    )
    parser.add_argument(
        '-p', '--path', type=str, help='Path', required=False
    )
    parser.add_argument(
        '-e', '--enabled', type=bool, help='Enabled', required=False
    )
    parser.add_argument(
        '-pm', '--port_map', type=str, help='Port-Map', required=False
    )
    

    args = parser.parse_args()

    return args.action, args.email, args.user, args.pw, args.cert_path
    
    def main():
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
