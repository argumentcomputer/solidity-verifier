import json
import os
import sys

state_file = sys.argv[1]
if not os.path.exists(state_file):
    print("state (json) input file is missing")
    exit(1)

# TODO add some input validation for ETH address
CONTRACT_ADDRESS = sys.argv[2]

with open(os.path.basename(state_file)) as state:
    data = json.load(state)

accounts = data['accounts']
contract = accounts[CONTRACT_ADDRESS]
storage = contract['storage']

# There are some confirmed issues with parser in cast / foundry, so this sometimes causes wrong values loading into the state,
# which we need to manually modify. Below are detected values and correspondent modifications
#
# See also https://github.com/foundry-rs/foundry/issues/5302

for key in storage:
    value = storage[key]
    if (value == "0x6582018229284824168619876730229402019930943462534319453394436096"):
        storage[key] = storage[key].replace('0x6582018229284824168619876730229402019930943462534319453394436096', '0x100000000000000000000000000000000000000000000000000000')
    if (value == "0x3291009114642412084309938365114701009965471731267159726697218048"):
        storage[key] = storage[key].replace('0x3291009114642412084309938365114701009965471731267159726697218048', '0x80000000000000000000000000000000000000000000000000000')
    if (value == "0x1645504557321206042154969182557350504982735865633579863348609024"):
        storage[key] = storage[key].replace('0x1645504557321206042154969182557350504982735865633579863348609024', '0x40000000000000000000000000000000000000000000000000000')

with open(os.path.basename(state_file), 'w') as f:
    f.truncate()
    json.dump(data, f)
