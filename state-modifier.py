from collections import namedtuple
import json
import os
import sys
import binascii


state_file = sys.argv[1]
if not os.path.exists(state_file):
    print("state (json) input file is missing")
    exit(1)

with open(os.path.basename(state_file)) as state:
    data = json.load(state)

accounts = data['accounts']
contract = accounts['0xe7f1725e7734ce288f8367e1bb143e90bb3f0512']
storage = contract['storage']

# https://github.com/foundry-rs/foundry/issues/5302
for key in storage:
    value = storage[key]
    if (value == "0x6582018229284824168619876730229402019930943462534319453394436096"):
        storage[key] = storage[key].replace('0x6582018229284824168619876730229402019930943462534319453394436096', '0x100000000000000000000000000000000000000000000000000000')
    if (value == "0x3291009114642412084309938365114701009965471731267159726697218048"):
        storage[key] = storage[key].replace('0x3291009114642412084309938365114701009965471731267159726697218048', '0x80000000000000000000000000000000000000000000000000000')
    if (value == "0x1645504557321206042154969182557350504982735865633579863348609024"):
        storage[key] = storage[key].replace('0x1645504557321206042154969182557350504982735865633579863348609024', '0x40000000000000000000000000000000000000000000000000000')

with open('state-modified.json', 'w') as f:
    json.dump(data, f)