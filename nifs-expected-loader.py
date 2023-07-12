from collections import namedtuple
import os

NifsData = namedtuple (
    '_NifsData', (
        'comm_W_x',
        'comm_W_y',
        'comm_E_x',
        'comm_E_y',
        'X',
        'u',
    )
)

PRIVATE_KEY = "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"
CONTRACT_ADDRESS = "0x959922be3caee4b8cd9a407cc3ac1c251c2007b1"
PUSH_TO_NIFS_OUTPUT_EXPECTED_FUN = "pushToNifsOutputExpected(uint256,uint256,uint256,uint256,uint256[],uint256)"

nifsData = NifsData(
    "0x20d8b3ce43c23bce83bf27d0a4b11239f633beda0ccde5e42263ba9ca1016f02",
    "0x2900ce856300a2304f46e19356be348836ed7628ec7bb752102dffbf588eb295",
    "0x1197ae01c70e59dbbd5ac797fb7b38780d0b780665671c976f435e796cc983f6",
    "0x0352530d5b6c0e047cc4b5587a1e0a69af9dce2338546bd5473fe5a11d70bd3c",
    [
        "0x1db2c0c8e0e4c94b326d04f9d69a496737eaa2852f693492700c6847a35726f2",
        "0x0b5b6a092d6d8406a62579e1cc2dc0b209c821e13fc3f2e846ecb90659ad413f"
    ],
    "0x00000000000000000000000000000001be290d4c014dff424259e57be62191c4",
)

def pushToNIFS(data):
    command = 'cast send' + ' '
    command = command + CONTRACT_ADDRESS + ' \"'
    command = command + PUSH_TO_NIFS_OUTPUT_EXPECTED_FUN + '\" \"'
    command = command + str(int(data.comm_W_x, 16)) + '\" \"'
    command = command + str(int(data.comm_W_y, 16)) + '\" \"'
    command = command + str(int(data.comm_E_x, 16)) + '\" \"'
    command = command + str(int(data.comm_E_y, 16)) + '\" \"['
    for item in data.X:
        if item != data.X[len(data.X)-1]:
            command = command + str(int(item, 16)) + ","
        else:
            # handle last item (no comma in the end)
            command = command + str(int(item, 16))
    command = command + ']\" \"'
    command = command + str(int(data.u, 16)) + '\" '
    command = command + '--private-key ' + PRIVATE_KEY
    os.system(command)

pushToNIFS(nifsData)

