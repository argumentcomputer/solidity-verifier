import subprocess
import sys
import os
import re

file_path = 'rust-reference-info.txt'

def parse_variables_from_file(file_path):
    variables = {}
    with open(file_path, 'r') as file:
        content = file.read()
        # Define regex patterns for matching variables
        nova_url_pattern = r'\$NOVA_URL\s*=\s*\"(.+?)\"'
        nova_commit_pattern = r'\$NOVA_COMMIT\s*=\s*\"(.+?)\"'

        # Match variables using regular expressions
        nova_url_match = re.search(nova_url_pattern, content)
        nova_commit_match = re.search(nova_commit_pattern, content)

        # Extract matched variables
        if nova_url_match:
            variables['NOVA_URL'] = nova_url_match.group(1)
        if nova_commit_match:
            variables['NOVA_COMMIT'] = nova_commit_match.group(1)

    return variables

# python generate_contract_input.py https://github.com/artem-bakuta/Nova.git 3838031868ca3f2783c01299546849860bfd36d2
if __name__ == "__main__":
    nova_repo_arg = ""
    nova_commit_arg = ""

    if len(sys.argv) > 1:
        nova_repo_arg = sys.argv[1]
        nova_commit_arg = sys.argv[2]

    # Configurations
    parsed_variables = parse_variables_from_file(file_path)
    nova_repo_url = nova_repo_arg if nova_repo_arg else parsed_variables['NOVA_URL']
    nova_commit_hash = nova_commit_arg if nova_commit_arg else parsed_variables['NOVA_COMMIT']
    print("Pulling project from: " + nova_repo_url + " " + nova_commit_hash)
    target_directory = "verify_cache"
    nova_directory = "nova"

    if os.path.exists(target_directory):
        subprocess.run(['rm', '-rf', target_directory], check=True)
    os.mkdir(target_directory)
    os.mkdir(target_directory + "/" + nova_directory)
    os.chdir(target_directory)
    os.system(f"git clone {nova_repo_url} {nova_directory}")
    os.chdir(nova_directory)
    os.system(f"git checkout {nova_commit_hash}")

    # Build the Nova project
    os.system(f"cargo test solidity_compatibility_e2e_pasta --release -- --ignored")
    print("Copy generated keys from Nova...")
    os.system(f"cp vk.json compressed-snark.json ../../.")
