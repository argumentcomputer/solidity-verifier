import subprocess
import sys
import os

# python grumpkin_json_generator.py https://github.com/lurk-lab/Nova.git d5f5fb5e557b99cb111f2d5693aa34fe30722750
if __name__ == "__main__":
    # Configurations
    nova_repo_url = sys.argv[1]
    nova_commit_hash = sys.argv[2]
    target_directory = "verify_cache"
    nova_directory = "nova"

    # Main logic
    if os.path.exists(target_directory):
        subprocess.run(['rm', '-rf', target_directory], check=True)
    os.mkdir(target_directory)
    os.mkdir(target_directory + "/" + nova_directory)
    os.chdir(target_directory)
    os.system(f"git clone {nova_repo_url} {nova_directory}")
    os.chdir(nova_directory)
    os.system(f"git checkout {nova_commit_hash}")
    os.system(f"cargo test solidity_compatibility_e2e_grumpkin --release -- --ignored")
    print("Copy generated keys form Nova...")
    os.system(f"cp vk-grumpkin.json compressed-snark-grumpkin.json ../../.")